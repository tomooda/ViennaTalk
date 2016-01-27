code generation-expressions
casesExpressionAlternative: aViennaNode env: aDictionary
	| patlist expr |
	patlist := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	^ {patlist.
	expr}