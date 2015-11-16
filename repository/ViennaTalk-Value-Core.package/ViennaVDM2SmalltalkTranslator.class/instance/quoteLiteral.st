parsers-literals
quoteLiteral
	^ super quoteLiteral ==> [ :quote | '#''' , quote , '''' ]