code generation-statements
nondeterministicStatement: aViennaNode env: aDictionary
	^ 'ViennaRuntimeUtil shuffleDo: {' , ('.' join: ((self generateAll: aViennaNode env: aDictionary) collect: [ :s | '[' , s , ']' ]))
		, '}'