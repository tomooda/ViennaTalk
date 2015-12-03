tests-definitions
testRecordTypeDefinition
	self
		assert: (grammar recordTypeDefinition end parse: 'T::t1 f2:t2 f3:-t3')
		equals:
			{'T'.
			{'t1'.
			{'f2'.
			't2'}.
			{'f3'.
			't3'}}.
			nil}.
	self
		assert: (grammar recordTypeDefinition end parse: 'T::t1 f2:t2 f3:-t3 inv p == e')
		equals:
			{'T'.
			{'t1'.
			{'f2'.
			't2'}.
			{'f3'.
			't3'}}.
			{'p'.
			'e'}}