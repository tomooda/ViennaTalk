tests-expressions
testConnectives2
	#('<=>' '=>' 'or' 'and')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]