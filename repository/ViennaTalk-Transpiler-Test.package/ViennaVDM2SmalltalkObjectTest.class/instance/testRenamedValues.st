tests-imports
testRenamedValues
	| obj |
	obj := self
		transpile:
			'
		module T
		exports all
		definitions
		values 
			zero = 0
		end T
		module M
		imports from T values zero renamed z
		exports all
		definitions
		functions
			isZero : int -> bool
			isZero(x) == x = z
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`isZero(1)') equals: false.
	self assert: (obj evaluateExpression: 'M`isZero(0)') equals: true