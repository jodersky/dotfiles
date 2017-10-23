cancelable in Global := true

// don't create target directory when starting sbt in non-project directory
// (e.g. when running sbt-new)
import java.nio.file.Files
target := {
  val buildSbt = new File("build.sbt")
  val projectSbt = new File("project.sbt")
  val project = new File("project")

  if (buildSbt.exists || projectSbt.exists || project.exists)
    target.value
  else
    Files.createTempDirectory("sbt-new").toFile
}
