parsers-symbols
identifier
	^ (self initialLetter , followingLetter star) flatten
		==> [ :str | 
			((self prefixes
				anySatisfy: [ :p | str size >= p size and: [ (1 to: p size) allSatisfy: [ :i | (str at: i) = (p at: i) ] ] ])
				or: [ self keywords includes: str ])
				ifTrue: [ PPFailure message: 'a keyword or prefixed word can not be an identifier' ]
				ifFalse: [ str ] ]