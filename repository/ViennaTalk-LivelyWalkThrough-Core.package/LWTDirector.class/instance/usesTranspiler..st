accessing
usesTranspiler: aBoolean
	aBoolean = true
		ifTrue: [ self useTranspiler ]
		ifFalse: [ self useInterpreter ]