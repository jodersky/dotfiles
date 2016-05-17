/*
 * PGP
 */
import com.typesafe.sbt.pgp.PgpKeys._
pgpSigningKey in Global := Some(0x2CED17AB2B6D6F37l)
useGpgAgent in Global := true
useGpg in Global := true
