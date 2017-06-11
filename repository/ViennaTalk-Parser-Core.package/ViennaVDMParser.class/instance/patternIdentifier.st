parsers-patterns
patternIdentifier
	^ super patternIdentifier
		=>> [ :start :end :stringOrNil | 
			ViennaNode
				label: 'PatternIdentifier'
				start: start
				end: end
				with: stringOrNil ]