tests-code generation-statements
testCasesStatementEnv
	| node |
	node := ViennaVDMParser new statement end
		parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, x -> a:=x + 2, others -> a:=undefined end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a') equals: 3.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, others -> a:=1 end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a') equals: 1.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set> end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self should: [ Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a' ] raise: ViennaNoMatch