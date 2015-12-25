parsers-expressions-basics
tokenConstructor
	^ super tokenConstructor ==> [ :expr | '(ViennaToken with: ' , expr , ')' ]