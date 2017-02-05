parsers-definitions
parameterTypes
	^ (lparen , self patternTypePairList optional , rparen)
		==> [ :triple | triple second ifNil: [ Array new ] ]