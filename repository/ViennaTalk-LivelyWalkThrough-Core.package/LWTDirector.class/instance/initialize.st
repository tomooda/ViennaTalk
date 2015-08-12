initialize-release
initialize
	super initialize.
	actions := Dictionary new.
	frames := Array new writeStream.
	lastFrame := nil.
	cuts := Dictionary new