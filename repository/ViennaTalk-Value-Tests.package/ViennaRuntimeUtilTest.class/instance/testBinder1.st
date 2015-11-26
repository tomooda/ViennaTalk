tests-matching-binder
testBinder1
	| matcher binder |
	matcher := '(ViennaRuntimeUtil matchIdentifier: ''x'')'.
	binder := ViennaRuntimeUtil binder: matcher with: '1' vars: #('x').
	self assert: (Compiler evaluate: '| x |' , binder , '. x') equals: 1