tests-definitions
testTypeSynonym
	self
		assert: (grammar typeSynonym end parse: 't = t1')
		equals:
			{'t'.
			't1'.
			nil}.
	self
		assert: (grammar typeSynonym end parse: 't = t1 inv p == e')
		equals:
			{'t'.
			't1'.
			{'p'.
			'e'}}