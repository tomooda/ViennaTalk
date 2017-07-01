code generation-statements
casesStatementAlternative: aViennaNode env: aDictionary
	| patlist statement |
	patlist := self generate: aViennaNode first env: aDictionary.
	statement := self generate: aViennaNode second env: aDictionary.
	^ {patlist.
	statement}