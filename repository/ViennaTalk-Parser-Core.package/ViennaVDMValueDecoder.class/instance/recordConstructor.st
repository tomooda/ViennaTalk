parsers-expressions
recordConstructor
	^ super tokenConstructor ==> [ :arg | ViennaToken with: arg ]