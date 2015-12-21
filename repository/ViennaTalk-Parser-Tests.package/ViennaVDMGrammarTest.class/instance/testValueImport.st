tests-interfaces
testValueImport
	self assert: (grammar valueImport end parse: 'v') equals: #('v' nil nil).
	self assert: (grammar valueImport end parse: 'v :t') equals: #('v' 't' nil).
	self assert: (grammar valueImport end parse: 'v1 renamed v2') equals: #('v1' nil 'v2').
	self assert: (grammar valueImport end parse: 'v1 : t renamed v2') equals: #('v1' 't' 'v2')