evaluating
evaluate: aString in: moduleName ifError: errorBlock
	Cursor wait
		showWhile: [ | result |
			[ result := (moduleName = self defaultModule
				ifTrue: [ object ]
				ifFalse: [ object at: moduleName ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
				evaluateExpression: aString
				with: transpiler
				ifError: [ :msg | ^ errorBlock cull: msg ] ]
				on: Error
				do: [ :ex | 
					^ errorBlock value: ex messageText ].
			self changed: #state.
			^ result == object
				ifTrue: [ nil ]
				ifFalse: [ result ] ]