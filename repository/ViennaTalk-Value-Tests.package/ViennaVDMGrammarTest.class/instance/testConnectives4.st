tests-expressions
testConnectives4
	#('<=>' 'or' 'and')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2 ' , op , ' e3') equals: #(#('e1' 'e2') 'e3') ]