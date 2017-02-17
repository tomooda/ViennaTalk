tests-imports
testImportsFunctions
	| obj |
	obj := self
		transpile:
			'
		module T
		exports all
		definitions
		functions 
			succ : nat -> nat
			succ(x) == x + 1;
		end T
		module M
		imports from T functions succ
		exports all
		definitions
		functions
			next : int -> int
			next(x) == T`succ(x)
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next(1)' ifError: [  ]) equals: 2.
	self
		should: [ obj evaluateExpression: 'M`next(-1)' ifError: [  ] ]
		raise: ViennaRuntimeTypeError