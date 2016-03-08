tests-free variables-statements
testFreeVariablesCasesExpressionAlternativeBoundVarsInto
	| node binds |
	node := ViennaVDMParser new casesStatementAlternative end parse: 'p1 munion p2, p1 union p2 -> op(p1, p2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatementAlternative'.
	binds := Set new.
	self assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new) equals: {'op'} asSet