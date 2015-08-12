initialize-release
initialize
	super initialize.
	eventActionDict := Dictionary new.
	moveable := self defaultMoveable.
	showsName := self defaultShowsName