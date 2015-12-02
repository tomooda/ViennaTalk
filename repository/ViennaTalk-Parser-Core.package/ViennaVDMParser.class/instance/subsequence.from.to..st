parsers-expressions-operators
subsequence: sequence from: start to: end
	^ ViennaNode
		label: 'Subsequence'
		with: sequence
		with: start
		with: end