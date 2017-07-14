addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.0.0")

// Check if newer versions of library dependencies are available
addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.1.10")

// Get a graph of all dlibrary ependencies (including transitive ones)
addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

// ENSIME brings Scala and Java IDE-like features to your favourite text editor
addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.13")

// Enable fast dependency resolution
// can be disabled with `sbt -Dcoursier=false`
//sys.props.get("coursier") match {
//  case Some("false") => Seq()
//  case _ => addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC5")
//}
