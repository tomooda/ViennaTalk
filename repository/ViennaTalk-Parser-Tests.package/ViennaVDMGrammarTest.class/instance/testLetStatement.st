tests-statements
testLetStatement
	self assert: (grammar statement end parse: 'let s:nat = 1 in skip') equals: #(#(#('s' 'nat' '1')) nil)