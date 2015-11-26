tests-matching-binder
testBinder2
	| matcher binder |
	matcher := '
		(ViennaRuntimeUtil matchTuple: {
			(ViennaRuntimeUtil matchIdentifier: ''x'') . 
			(ViennaRuntimeUtil matchIdentifier: ''y'') . 
			(ViennaRuntimeUtil matchValue: 3)})'.
	binder := ViennaRuntimeUtil binder: matcher with: '#(1 2 3)' vars: #('x' 'y').
	self assert: (Compiler evaluate: '| x y |' , binder , '. {x . y}') equals: #(1 2)