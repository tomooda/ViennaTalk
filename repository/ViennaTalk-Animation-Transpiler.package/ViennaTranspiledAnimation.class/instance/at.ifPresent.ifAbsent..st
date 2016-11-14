accessing
at: aString ifPresent: presentBlock ifAbsent: absentBlock
	| separatorIndex target name value |
	separatorIndex := aString indexOf: $`.
	separatorIndex = 0
		ifTrue: [ target := object.
			name := aString ]
		ifFalse: [ | moduleName |
			moduleName := aString copyFrom: 1 to: separatorIndex - 1.
			target := moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: moduleName ifAbsent: [ ^ absentBlock value ] ].
			name := aString copyFrom: separatorIndex + 1 to: aString size ].
	[ value := target instVarNamed: name ]
		on: Error
		do: [ :ex | ^ absentBlock value ].
	^ presentBlock value: value