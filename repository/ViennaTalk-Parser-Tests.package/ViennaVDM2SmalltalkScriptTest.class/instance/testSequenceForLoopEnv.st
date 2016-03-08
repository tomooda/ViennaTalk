tests-code generation-statements
testSequenceForLoopEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'for i in [5,6,7] do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for mk_(i,j) in [mk_(1, 2), mk_(2, 3)] do x := x + i*j'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 8