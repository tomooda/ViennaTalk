parsers-types
quoteType
	^ super quoteType ==> [ :string | ViennaNode label: 'QuoteType' with: string ]