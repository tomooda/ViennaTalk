parsers-patterns
matchValueLiteral
	^ super matchValueLiteral
		==> [ :literal | 
			| varGenerator valVar |
			varGenerator := self varNameGenerator: 'lit' uniqueIn: (Array with: literal).
			valVar := varGenerator value.
			{#().
			('[:' , valVar , '|' , valVar , '=' , literal , ']')} ]