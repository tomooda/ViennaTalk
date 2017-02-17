tests-imports
testRenamedTypes
	| obj |
	obj := self
		transpile:
			'
		module T
		exports all
		definitions
		types 
			n = int inv x == x >= 0
		end T
		module M
		imports from T types n renamed n0
		exports all
		definitions
		functions
			succ : n0 -> n0
			succ(x) == x + 1
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`succ(1)') equals: 2.
	self should: [ obj evaluateExpression: 'M`succ(-1)' ] raise: ViennaRuntimeTypeError