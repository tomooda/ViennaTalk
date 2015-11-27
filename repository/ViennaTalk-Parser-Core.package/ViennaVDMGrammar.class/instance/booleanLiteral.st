parsers-literals
booleanLiteral
	^ (self reserved: 'true' asParser ==> [ :t | true ]) / ('false' asParser ==> [ :t | false ])