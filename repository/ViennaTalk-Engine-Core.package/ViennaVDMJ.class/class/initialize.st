class initialization
initialize
	super initialize.
	Smalltalk isHeadless
		ifFalse: [ self install ]