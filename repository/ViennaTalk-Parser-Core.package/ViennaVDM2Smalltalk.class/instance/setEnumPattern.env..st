code generation-patterns
setEnumPattern: aViennaNode env: aDictionary
	| elementPatterns |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elementPatterns) , '})'