accessing
specification: aString ifError: errorBlock
	transpiler := ViennaVDM2SmalltalkObject new.
	aString
		ifEmpty: [ object := ViennaTranspiledObject new.
			envs := Dictionary new
				at: self defaultModule put: Dictionary new;
				yourself ]
		ifNotEmpty: [ | ast |
			ast := parser parse: aString.
			ast isPetitFailure
				ifTrue: [ ^ errorBlock value: ast message ].
			object := transpiler generate: ast.
			envs := transpiler buildEnv: ast ].
	specification := aString.
	self changed: #specification.
	self changed: #state