parsers-statements
multipleAssignStatement
	| assignStatement |
	assignStatement := self assignStatement.
	^ ((self reserved: 'atomic') , lparen , assignStatement , semicolon
		, (assignStatement separatedBy: semicolon) withoutSeparators , rparen)
		==> [ :array | 
			| assign1 assigns |
			assign1 := array third.
			assigns := array fifth.
			assigns copyWithFirst: assign1 ]