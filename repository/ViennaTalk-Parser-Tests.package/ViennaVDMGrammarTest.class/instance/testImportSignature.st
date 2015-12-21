tests-interfaces
testImportSignature
	self assert: (grammar importSignature end parse: 'values v1; v2;') equals: #(#('v1' nil nil) #('v2' nil nil)).
	self assert: (grammar importSignature end parse: 'functions f') equals: #(#('f' nil nil))