code generation-statements
mapOrSequenceReference: aViennaNode env: aDictionary
	| stateDesig expr ident path |
	stateDesig := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	stateDesig isString
		ifTrue: [ 
			ident := stateDesig.
			path := Array new ]
		ifFalse: [ 
			ident := stateDesig first.
			path := stateDesig second ].
	^ {ident.
	(path copyWith: expr)}