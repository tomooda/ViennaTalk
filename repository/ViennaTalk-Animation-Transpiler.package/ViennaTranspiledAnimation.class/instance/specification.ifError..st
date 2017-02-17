accessing
specification: aString ifError: errorBlock
	transpiler := ViennaVDM2SmalltalkObject new.
	aString
		ifEmpty: [ object := ViennaTranspiledObject new ]
		ifNotEmpty: [ | ast |
			ast := parser parse: aString.
			ast isPetitFailure
				ifTrue: [ ^ errorBlock value: ast message ].
			object := transpiler generate: ast ].
	specification := aString.
	self changed: #specification.
	self changed: #state