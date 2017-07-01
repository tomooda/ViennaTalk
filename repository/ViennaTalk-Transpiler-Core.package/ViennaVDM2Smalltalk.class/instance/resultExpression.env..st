code generation-expressions
resultExpression: aViennaNode env: aDictionary
	^ aDictionary at: 'RESULT' ifAbsent: [ 'RESULT' ]