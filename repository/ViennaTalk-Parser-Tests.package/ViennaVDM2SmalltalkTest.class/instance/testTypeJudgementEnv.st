tests-code generation-expressions
testTypeJudgementEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'is_(1, nat)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeJudgement'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'is_(-1, nat)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeJudgement'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false