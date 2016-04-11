utilities
indicesExpression: aViennaNode env: aDictionary
	| seqNode |
	seqNode := self generate: aViennaNode first env: aDictionary.
	^ '1 to: ' , seqNode , ' size'