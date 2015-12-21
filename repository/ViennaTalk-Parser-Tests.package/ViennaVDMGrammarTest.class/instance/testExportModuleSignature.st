tests-interfaces
testExportModuleSignature
	self assert: (grammar exportModuleSignature end parse: 'all') equals: 'all'.
	self
		assert: (grammar exportModuleSignature end parse: 'types t1; struct t2; values v1, v2 : nat; v3 : int')
		equals: #(#(#(nil 't1') #('struct' 't2')) #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')))