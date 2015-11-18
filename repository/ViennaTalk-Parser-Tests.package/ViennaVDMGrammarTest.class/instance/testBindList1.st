tests-patterns
testBindList1
	self assert: (grammar bindList end parse: 'v1,v2:t , v3 in set s') equals: #(#(#('v1' 'v2') 't') #(#('v3') 's'))