code generation-expressions
setRangeExpression: aViennaNode env: aDictionary
	^ '(', (self intervalExpression: aViennaNode env: aDictionary) , ') asSet'