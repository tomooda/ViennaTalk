parsers-literals
decimalLiteral
	^ (#digit asParser plus , ((self operator: $.) , #digit asParser plus) optional
		, ($e asParser / $E asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) flatten trim
		==> #asLowercase