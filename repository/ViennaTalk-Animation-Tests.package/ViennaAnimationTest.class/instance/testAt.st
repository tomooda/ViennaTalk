tests
testAt
	animation specification: '
	state S of 
		x : int 
		init s == s = mk_S(0) 
	end'.
	animation init.
	self assert: (animation at: 'DEFAULT`x') equals: 0.