private
transpile: aString runtimeTypeCheck: aBoolean1 runtimeAssertionCheck: aBoolean2 do: aBlock
	| ast transpiler |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ Error signal: 'syntax error' ].
	transpiler := ViennaVDM2SmalltalkObject new.
	transpiler
		runtimeTypeCheck: aBoolean1;
		runtimeAssertionCheck: aBoolean2.
	aBlock value: (transpiler generate: ast) value: (transpiler buildEnv: ast) value: transpiler