tests-expressions
testApply4
	self assert: (grammar expression end parse: 'f(a1,a2)(a3)') equals: #(#('f' #('a1' 'a2')) #('a3'))