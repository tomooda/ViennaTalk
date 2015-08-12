initialize-release
initialize
	super initialize.
	showsDiagram := false.
	self extent: self defaultExtent.
	self buildTextPane