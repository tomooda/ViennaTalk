tests-interfaces
testTypeImport
	self assert: (grammar typeImport end parse: 't') equals: #('t' nil).
	self assert: (grammar typeImport end parse: 't = nat') equals: #(#('t' 'nat' nil) nil).
	self assert: (grammar typeImport end parse: 't1 renamed t2') equals: #('t1' 't2').
	self assert: (grammar typeImport end parse: 't1 = nat renamed t2') equals: #(#('t1' 'nat' nil) 't2')