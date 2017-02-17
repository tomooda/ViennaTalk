tests-imports
testRenamedFunctions
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
		imports from T functions succ renamed successor
		exports all
		definitions
		functions
			next : int -> int
			next(x) == successor(x)
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next(1)') equals: 2.
	self should: [ obj evaluateExpression: 'M`next(-1)' ] raise: ViennaRuntimeTypeError