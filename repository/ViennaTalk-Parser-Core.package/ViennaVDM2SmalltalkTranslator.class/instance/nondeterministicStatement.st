parsers-statements
nondeterministicStatement
	^ super nondeterministicStatement
		==> [ :statements | 'ViennaRuntimeUtil shuffleDo: {' , ('.' join: (statements collect: [ :s | '[' , s , ']' ])) , '}' ]