code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| quin |
	quin := super stateDefinition: aViennaNode env: aDictionary.
	^ quin first , quin second , '.' , String cr , quin third
		, (quin fourth ifNil: [ '' ] ifNotNil: [ :inv | '.' , String cr , inv ]) , '. state := [' , quin fifth , ']'