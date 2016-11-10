private
transpile: aString runtimeTypeCheck: aBoolean1 runtimeAssertionCheck: aBoolean2 do: aBlock
	| ast transpiler obj |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ Error signal: 'syntax error' ].
	transpiler := ViennaVDM2SmalltalkObject new.
	transpiler
		runtimeTypeCheck: aBoolean1;
		runtimeAssertionCheck: aBoolean2.
	obj := transpiler generate: ast.
	transpiler defaultEnv: ((transpiler buildEnv: ast) at: 'DEFAULT').
	^ aBlock value: obj value: transpiler