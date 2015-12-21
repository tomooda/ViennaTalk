tests-interfaces
testValuesSignature
	self
		assert: (grammar valuesSignature end parse: 'values v1, v2 : nat; v3 : int')
		equals: #(#(#('v1' 'v2') 'nat') #(#('v3') 'int'))