tests-expressions
testSubsequence2
	self assert: (grammar expression end parse: 's(i1,...,i2) ( i3 , ... , i4 )') equals: #(#('s' 'i1' 'i2') 'i3' 'i4')