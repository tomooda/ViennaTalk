tests-interfaces
testExportSignature
	self assert: (grammar exportSignature end parse: 'types t1; struct t2;') equals: #(#(nil 't1') #('struct' 't2')).
	self
		assert: (grammar exportSignature end parse: 'values v1, v2 : nat; v3 : int')
		equals: #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')).
	self
		assert: (grammar exportSignature end parse: 'functions f1, f2[@t] : @t -> bool; f3 : nat -> nat')
		equals: #(#(#('f1' 'f2') #('@t') #('@t' 'bool')) #(#('f3') #() #('nat' 'nat'))).
	self
		assert: (grammar exportSignature end parse: 'operations op1, op2 : nat ==> (); op3 : () ==> nat;')
		equals: #(#(#('op1' 'op2') #('nat' nil)) #(#('op3') #(nil 'nat')))