tests-code generation-statements
testIfStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'if true then x := x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfStatement'.
	self assert: (Compiler evaluate: '|x| x:= 0.' , (ViennaVDM2SmalltalkScript new generate: node) , '.x') equals: 1.
	node := ViennaVDMParser new statement end parse: 'if false then x := 1 elseif true then x := 2 else x := 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfStatement'.
	self assert: (Compiler evaluate: '|x|' , (ViennaVDM2SmalltalkScript new generate: node) , '.x') equals: 2