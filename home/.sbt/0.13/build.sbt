import com.typesafe.sbt.pgp.PgpKeys._
pgpSigningKey in Global := Some(0x2CED17AB2B6D6F37l)
useGpgAgent in Global := true
useGpg in Global := true

//don't automatically release on publish
bintray.BintrayKeys.bintrayReleaseOnPublish := false

//ignore source and doc jars in ensime
transitiveClassifiers in Global := List("")
