tests-code generation-statements
testSetForLoopEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'for all i in set {5,6,7} do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for all mk_(i, j) in set {mk_(1, 2), mk_(2, 3)} do x := x + i*j'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 8.
	node := ViennaVDMParser new statement end parse: 'for all s in set power { 1,...,3 } do x := x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 8