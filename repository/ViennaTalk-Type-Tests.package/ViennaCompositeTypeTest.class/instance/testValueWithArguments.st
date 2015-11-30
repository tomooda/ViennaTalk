tests
testValueWithArguments
	(composite valueWithArguments: #(-1 1 #'<QUOTE>'))
		in: [ :record | 
			self assert: (record at: 1) equals: -1.
			self assert: (record at: 2) equals: 1.
			self assert: (record at: 'f2') equals: 1.
			self assert: (record at: 3) equals: #'<QUOTE>'.
			self assert: (record at: 'f3') equals: #'<QUOTE>'.
			self assert: record equals: (composite valueWithArguments: #(-1 1 #'<QUOTE>')).
			self assert: record equals: (composite valueWithArguments: #(-1 0 #'<QUOTE>')).
			self deny: record = (composite valueWithArguments: #(1 1 #'<QUOTE>')) ]