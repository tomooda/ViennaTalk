tests-code generation-statements
testLetStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in a:=f(x * y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) , '.a') equals: 7