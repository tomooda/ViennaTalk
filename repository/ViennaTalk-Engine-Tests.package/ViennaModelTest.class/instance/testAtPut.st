tests
testAtPut
	vdmc specification: '
	state S of 
		x : int 
		init s == s = mk_S(0)
	end
	operations
		get : () ==> int
		get() == return x;'.
	vdmc at: 'DEFAULT`x' put: 10.
	self assert: (vdmc evaluate: 'get()') equals: 10.