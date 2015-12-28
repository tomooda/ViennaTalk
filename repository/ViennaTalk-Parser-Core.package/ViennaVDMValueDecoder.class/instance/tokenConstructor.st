parsers-expressions
tokenConstructor
	^ super tokenConstructor ==> [ :arg | ViennaToken with: arg ]