tests-code generation-expressions
testMapOrSequenceReferenceEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'm(3) := <three>'.
	self deny: node isPetitFailure.
	self assert: node first label = 'MapOrSequenceReference'