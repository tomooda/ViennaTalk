parsers-types
quoteType
	^ super quoteType ==> [ :quote | '(ViennaType quote: ' , quote , ')' ]