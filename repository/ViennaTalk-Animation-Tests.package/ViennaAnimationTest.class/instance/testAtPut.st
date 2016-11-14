tests
testAtPut
	animation specification: '
	state S of 
		x : int 
		init s == s = mk_S(0)
	end
	operations
		get : () ==> int
		get() == return x;'.
	animation at: 'DEFAULT`x' put: 10.
	self assert: (animation evaluate: 'get()') equals: 10.