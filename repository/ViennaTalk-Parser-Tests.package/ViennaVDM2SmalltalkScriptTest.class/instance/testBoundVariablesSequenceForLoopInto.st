tests-bound variables-statements
testBoundVariablesSequenceForLoopInto
	| node binds |
	node := ViennaVDMParser new sequenceForLoop end parse: 'for v in s do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet