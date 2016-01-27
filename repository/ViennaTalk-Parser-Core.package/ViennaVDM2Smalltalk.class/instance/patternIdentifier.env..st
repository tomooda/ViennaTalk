code generation-patterns
patternIdentifier: aViennaNode env: aDictionary
	| identifierOrNil |
	identifierOrNil := self generate: aViennaNode first env: aDictionary.
	^ {(identifierOrNil ifNil: [ #() ] ifNotNil: [ {identifierOrNil} ]).
	('(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')')}