tests-definitions
testExtendedExplicitOperationDefinition
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 == skip ext rd v1:t4 wt v2:t5 pre b1 post b2 errs i2:e1->e2')
		equals:
			#('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil #(#('rd' #('v1') 't4') #('wt' #('v2') 't5')) 'b1' 'b2' #(#('i2' 'e1' 'e2'))).
	self
		assert: (grammar operationDefinition end parse: 'op(p1:t1, p2:t2) i1:t3 == skip post b2')
		equals: #('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil nil nil 'b2' nil).
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 == skip ext rd v1:t4 wt v2:t5 pre b1  errs i2:e1->e2')
				isPetitFailure