tests-statements
testStateDesignator
	self assert: (grammar stateDesignator end parse: 'n.f1(i).f2(j)') equals: #(#(#(#('n' 'f1') 'i') 'f2') 'j').
	self assert: (grammar stateDesignator end parse: 'n') equals: 'n'