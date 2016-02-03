code generation-statements
fieldReference: aViennaNode env: aDictionary
	| stateDesig field ident path |
	stateDesig := self generate: aViennaNode first env: aDictionary.
	field := self generate: aViennaNode second env: aDictionary.
	stateDesig isString
		ifTrue: [ 
			ident := stateDesig.
			path := Array new ]
		ifFalse: [ 
			ident := stateDesig first.
			path := stateDesig second ].
	^ {ident.
	(path copyWith: field storeString)}