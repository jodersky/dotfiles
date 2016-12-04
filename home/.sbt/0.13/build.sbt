import com.typesafe.sbt.pgp.PgpKeys._
gpgCommand in Global := "gpg2"
pgpSigningKey in Global := Some(0x2CED17AB2B6D6F37l)
useGpgAgent in Global := true
useGpg in Global := true

import org.ensime.EnsimeCoursierKeys._
ensimeServerVersion in ThisBuild := "2.0.0-SNAPSHOT"
