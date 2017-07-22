tests-imports
testImportsOperations
	| obj |
	obj := self
		transpile:
			'
		module T
		exports all
		definitions
		state S of
			count : nat
			init s == s = mk_S(0)
		end
		operations 
			succ : () ==> nat
			succ() == (count := count + 1; return count);
		end T
		module M
		imports from T operations succ : () ==> nat
		exports all
		definitions
		operations
			next : () ==> nat
			next() == return T`succ()
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next()' ifError: [  ]) equals: 1.
	self assert: (obj evaluateExpression: 'M`next()' ifError: [  ]) equals: 2