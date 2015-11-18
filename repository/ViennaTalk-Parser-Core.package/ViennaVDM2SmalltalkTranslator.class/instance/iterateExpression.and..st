parsers-expressions-operators
iterateExpression: expr1 and: expr2
	^ '([:dict :n | | newDict | newDict := Dictionary new. dict keysDo: [:k | | v | v := k. n timesRepeat: [v := dict at: v]. newDict at: k put: v]. newDict] value: '
		, expr1 , ' value: ' , expr2 , ')'