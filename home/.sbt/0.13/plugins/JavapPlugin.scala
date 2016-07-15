import sbt._
import sbt.Keys._

object JavapPlugin extends AutoPlugin {

  override def requires = plugins.JvmPlugin
  override def trigger = allRequirements

  object autoImport {
    val javapOptions = settingKey[Seq[String]]("Options to pass to javap.")
    val javap = taskKey[Set[File]]("Disassemble byte code.")
  }
  import autoImport._

  override def projectSettings = Seq(
    javapOptions := Seq("-c", "-private", "-v"),
    javap := {
      val compiled: inc.Analysis = (compile in Compile).value
      val classFiles: Set[File] = compiled.relations.allProducts.toSet
      val outBaseDir = crossTarget.value / "javap"

      for (cf <- classFiles) yield {
        val outDir = Path.rebase(
          (classDirectory in Compile).value,
          crossTarget.value / "javap")(cf).get.getParentFile

        IO.createDirectory(outDir)

        val out: File = outDir / (cf.base + ".javap")

        streams.value.log.info("Disassembling " + out.getAbsolutePath)
        val opts = javapOptions.value.mkString(" ")
        val ev = (Process(s"javap ${opts} ${cf.getAbsolutePath}") #> out) ! streams.value.log
        if (ev != 0) sys.error(s"Error occured running javap. Exit code: ${ev}")
        out
      }
    }
  )
}



