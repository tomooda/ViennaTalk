evaluating
evaluate: aString in: moduleName ifError: errorBlock
	Cursor wait
		showWhile: [ | ast code result |
			ast := parser expression parse: aString.
			ast isPetitFailure
				ifTrue: [ ^ errorBlock value: ast message ].
			code := transpiler
				generate: ast
				env: (envs at: moduleName ifAbsent: [ ^ errorBlock value: 'unknown module name' ]).
			[ result := Compiler
				evaluate: code
				for:
					(moduleName = self defaultModule
						ifTrue: [ object ]
						ifFalse: [ object at: moduleName ifAbsent: [ ^ errorBlock value: 'unknown module name' ] ])
				logged: false ]
				on: Error
				do: [ :ex | ^ errorBlock value: ex messageText ].
			self changed: #state.
			^ result == object
				ifTrue: [ nil ]
				ifFalse: [ result ] ]