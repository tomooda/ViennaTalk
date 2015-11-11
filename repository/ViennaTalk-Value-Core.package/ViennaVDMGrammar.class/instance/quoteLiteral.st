parsers-literals
quoteLiteral
	^ ($< asParser , identifier , $> asParser) flatten trim