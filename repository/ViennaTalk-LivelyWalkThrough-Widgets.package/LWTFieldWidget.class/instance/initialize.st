initialize-release
initialize
	super initialize.
	showsName := true.
	showsDiagram := false.
	self extent: self defaultExtent.
	self buildTextPane