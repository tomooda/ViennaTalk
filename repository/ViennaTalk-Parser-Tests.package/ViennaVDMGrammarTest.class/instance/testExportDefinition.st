tests-interfaces
testExportDefinition
	self assert: (grammar exportDefinition end parse: 'exports all') equals: 'all'.
	self
		assert: (grammar exportDefinition end parse: 'exports types t1; struct t2; values v1, v2 : nat; v3 : int')
		equals: #(#(#(nil 't1') #('struct' 't2')) #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')))