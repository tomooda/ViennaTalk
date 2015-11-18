tests-types
testFieldSelect2
	self assert: (grammar expression end parse: 'r1.f1.f2') equals: #(#('r1' 'f1') 'f2')