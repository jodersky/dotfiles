import sbt._

import org.ensime.EnsimeKeys
import org.ensime.{ EnsimeConfig, EnsimeModule }

object EnsimeProjectSettings extends AutoPlugin {

  override def requires = org.ensime.EnsimePlugin
  override def trigger = allRequirements

  override def projectSettings = Seq(
    EnsimeKeys.ensimeConfigTransformer := {(cfg: EnsimeConfig) => {
      val config = EnsimeKeys.ensimeConfigTransformer.value(cfg)
      val cleanedModules = config.modules.map{ case (name, module) =>
        def badJar(name: String) = (
          name.startsWith("stax-api") ||
          name.startsWith("antlr")
        )
        name -> module.copy(sourceJars = module.sourceJars.filterNot(f => badJar(f.name)))
      }
      config.copy(modules = cleanedModules)
    }}
    //transitiveClassifiers in Global := List("")
  )
}
