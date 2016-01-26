code generation-expressions
casesExpressionAlternative: aViennaNode
	| patlist expr |
	patlist := self generate: aViennaNode first.
	expr := self generate: aViennaNode second.
	^ {patlist.
	expr}