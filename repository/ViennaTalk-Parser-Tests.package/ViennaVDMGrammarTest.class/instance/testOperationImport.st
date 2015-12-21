tests-interfaces
testOperationImport
	self assert: (grammar operationImport end parse: 'op') equals: #('op' nil nil).
	self assert: (grammar operationImport end parse: 'op : () ==> ()') equals: #('op' #(nil nil) nil).
	self assert: (grammar operationImport end parse: 'op1 renamed op2') equals: #('op1' nil 'op2').
	self assert: (grammar operationImport end parse: 'op1: nat ==> nat renamed op2') equals: #('op1' #('nat' 'nat') 'op2')