accessing
at: aString put: anObject
	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [ target := object.
			name := aString ]
		ifFalse: [ | moduleName |
			moduleName := aString copyFrom: 1 to: separatorIndex - 1.
			target := moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: (aString copyFrom: 1 to: separatorIndex - 1) ifAbsent: [ ^ nil ] ].
			name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name put: anObject ]
		on: Error
		do: [ :ex | ^ nil ].
	^ value