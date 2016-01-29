tests-interfaces
testFunctionImport
	self assert: (grammar functionImport end parse: 'f') equals: #('f' nil nil nil).
	self assert: (grammar functionImport end parse: 'f[@t]: @t -> @t') equals: #('f' #('@t') #('@t' '@t') nil).
	self assert: (grammar functionImport end parse: 'f1 renamed f2') equals: #('f1' nil nil 'f2').
	self
		assert: (grammar functionImport end parse: 'f1[@t]: @t -> @t renamed f2')
		equals: #('f1' #('@t') #('@t' '@t') 'f2')