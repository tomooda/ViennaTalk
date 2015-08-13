initialize-release
initialize
	super initialize.
	scripts := Dictionary new.
	frames := Array new writeStream.
	lastFrame := nil.
	cuts := Dictionary new