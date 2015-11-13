tests-expressions
testEvaluators2
	#(':>' ':->' '<:' '<-:' 'div' 'mod' 'rem' '*' '/' 'inter' '+' '-' 'union' '\' 'munion' '++' '^')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]