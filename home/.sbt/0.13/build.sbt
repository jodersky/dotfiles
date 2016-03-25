/*
 * PGP
 */
import com.typesafe.sbt.pgp.PgpKeys._
pgpSigningKey in Global := Some(0x2CED17AB2B6D6F37l)
useGpgAgent in Global := true
useGpg in Global := true

/*
 * Bintray
 */
bintray.BintrayKeys.bintrayReleaseOnPublish := false

/*
 * Ensime
 */
//ignore source and doc jars in ensime
//transitiveClassifiers in Global := List("")

/*
import org.ensime.{ EnsimeConfig, EnsimeModule }
import org.ensime.Imports._

EnsimeKeys.configTransformer := {(cfg: EnsimeConfig) => {
  val config = EnsimeKeys.configTransformer.value(cfg)
  val cleanedModules = config.modules.map{ case (name, module) =>
    val goodSrcJars = module.sourceJars.filterNot{f =>
      f.name.startsWith("stax-api")
    }
    name -> module.copy(sourceJars = goodSrcJars)
  }

  config.copy(modules = cleanedModules)
}}
 */
