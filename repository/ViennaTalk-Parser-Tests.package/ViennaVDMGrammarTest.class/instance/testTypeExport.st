tests-interfaces
testTypeExport
	self assert: (grammar typeExport end parse: 't') equals: #(nil 't').
	self assert: (grammar typeExport end parse: 'struct t') equals: #('struct' 't')