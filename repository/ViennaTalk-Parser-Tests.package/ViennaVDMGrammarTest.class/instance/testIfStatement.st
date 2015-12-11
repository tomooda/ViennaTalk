tests-statements
testIfStatement
	self
		assert: (grammar statement end parse: 'if cond1 then return e1 elseif cond2 then return e2 else return e3')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2')) 'e3').
	self assert: (grammar statement end parse: 'if cond1 then return e1 else return e2') equals: #(#(#('cond1' 'e1')) 'e2').
	self
		assert:
			(grammar statement end parse: 'if cond1 then return e1 elseif cond2 then return e2 elseif cond3 then return e3 else return e4')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2') #('cond3' 'e3')) 'e4').
	self assert: (grammar statement end parse: 'if cond1 then return e1') equals: #(#(#('cond1' 'e1')) nil)