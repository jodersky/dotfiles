
sys.props.get("coursier") match {
  case Some("false") => Seq()
  case _ => addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M12-1")
}

//addSbtPlugin("me.lessis" % "bintray-sbt" % "0.3.0")

addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "4.0.0")

addSbtPlugin("org.ensime" % "sbt-ensime" % "1.9.0")

addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.0.0")

addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.1.10")

addSbtPlugin("com.geirsson" %% "sbt-scalafmt" % "0.2.5")
