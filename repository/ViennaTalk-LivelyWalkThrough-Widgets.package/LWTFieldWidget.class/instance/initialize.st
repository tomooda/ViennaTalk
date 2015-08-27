initialize-release
initialize
	super initialize.
	showsDiagram := false.
	type = self defaultType.
	self buildTextPane