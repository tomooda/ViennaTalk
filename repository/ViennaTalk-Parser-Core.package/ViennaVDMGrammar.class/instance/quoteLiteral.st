parsers-literals
quoteLiteral
	^ self operator: ($< asParser , identifier , $> asParser) flatten