tests-expressions
testEvaluators1
	#('abs' 'floor' 'card' 'power' 'dinter' 'dunion' 'dom' 'rng' 'merge' 'len' 'elems' 'hd' 'tl' 'conc' 'inds' 'inverse')
		do: [ :unary | self assert: (grammar expression end parse: unary , ' e') equals: 'e' ]