tests-code generation-statements
testWhileLoopEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'while i <= 7 do (x := x + i; i := i + 1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'WhileLoop'.
	self assert: (Compiler evaluate: '|i x|i := 5. x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 18