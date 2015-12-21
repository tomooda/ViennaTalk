tests-interfaces
testExportTypesSignature
	self assert: (grammar exportTypesSignature end parse: 'types t1; struct t2;') equals: #(#(nil 't1') #('struct' 't2'))