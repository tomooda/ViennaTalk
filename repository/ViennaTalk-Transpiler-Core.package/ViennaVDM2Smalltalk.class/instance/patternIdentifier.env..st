code generation-patterns
patternIdentifier: aViennaNode env: aDictionary
	| identifierOrNil |
	identifierOrNil := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')'