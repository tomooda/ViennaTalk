initialize-release
initialize
	super initialize.
	moveable := self defaultMoveable.
	showsName := self defaultShowsName.
	frozen := false.
	self extent: self defaultExtent