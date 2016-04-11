code generation-types
quoteType: aViennaNode env: aDictionary
	| quote |
	quote := aViennaNode first.
	^ '(ViennaType quote: #' , (quote copyFrom: 2 to: quote size - 1) storeString , ')'