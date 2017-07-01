code generation-patterns
seqEnumPattern: aViennaNode env: aDictionary
	| elementPatterns |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchSequenceEnumeration: {' , (' . ' join: elementPatterns) , '})'