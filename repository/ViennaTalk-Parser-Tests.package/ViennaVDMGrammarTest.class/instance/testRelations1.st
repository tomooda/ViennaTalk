tests-expressions
testRelations1
	#('=' '<>' '<=' '>=' 'subset' 'psubset' 'in set' 'not in set')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]