tests-expressions
testEvaluators4
	#('<:' '<-:')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2 ' , op , ' e3') equals: #('e1' #('e2' 'e3')) ]