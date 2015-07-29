tests
testAt
	vdmc specification: '
	state S of 
		x : int 
		init s == s = mk_S(0) 
	end'.
	vdmc init.
	self assert: (vdmc at: 'DEFAULT`x') equals: 0.