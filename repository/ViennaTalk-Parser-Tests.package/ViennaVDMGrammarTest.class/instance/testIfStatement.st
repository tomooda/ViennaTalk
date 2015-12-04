tests-statements
testIfStatement
	self
		assert: (grammar expression end parse: 'if cond1 then e1 elseif cond2 then e2 else e3')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2')) 'e3').
	self assert: (grammar expression end parse: 'if cond1 then e1 else e2') equals: #(#(#('cond1' 'e1')) 'e2').
	self
		assert: (grammar expression end parse: 'if cond1 then e1 elseif cond2 then e2 elseif cond3 then e3 else e4')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2') #('cond3' 'e3')) 'e4')