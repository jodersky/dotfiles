import sbt._

import com.typesafe.sbt.SbtScalariform.ScalariformKeys
import org.ensime.Imports.EnsimeKeys
import org.ensime.{ EnsimeConfig, EnsimeModule }

object EnsimeProjectSettings extends AutoPlugin {

  override def requires = org.ensime.EnsimePlugin
  override def trigger = allRequirements

  override def projectSettings = Seq(
    EnsimeKeys.scalariform := ScalariformKeys.preferences.value, // workaround for ensime-sbt #148
    EnsimeKeys.configTransformer := {(cfg: EnsimeConfig) => {
      val config = EnsimeKeys.configTransformer.value(cfg)
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
