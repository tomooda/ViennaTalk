parsers-types
quoteType
	^ super quoteType
		=>> [ :start :end :string | 
			ViennaNode
				label: 'QuoteType'
				start: start
				end: end
				with: string ]