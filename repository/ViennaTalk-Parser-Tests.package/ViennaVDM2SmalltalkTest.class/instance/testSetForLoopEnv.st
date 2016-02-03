tests-code generation-statements
testSetForLoopEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'for all i in set {5,6,7} do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 18