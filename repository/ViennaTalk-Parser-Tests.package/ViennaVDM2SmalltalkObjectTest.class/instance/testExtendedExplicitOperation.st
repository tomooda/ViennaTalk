tests-type checking
testExtendedExplicitOperation
	| obj |
	obj := self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub(x:nat) res:nat == (count := count - x; return count)
	post count + x = count~ and count = res;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self assert: (obj instVarNamed: 'count') equals: 1.
	self
		assert: (obj evaluateExpression: 'post_sub(1, mk_State(9), mk_State(10), 9)')
		equals: true