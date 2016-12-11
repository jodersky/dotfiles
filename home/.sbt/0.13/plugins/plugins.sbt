addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.0.0")

addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.1.10")

addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.4")

sys.props.get("coursier") match {
  case Some("false") => Seq()
  case _ => addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M15-1")
}
