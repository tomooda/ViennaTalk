class initialization
startUp: resume
	Smalltalk isHeadless
		ifFalse: [ self install ]