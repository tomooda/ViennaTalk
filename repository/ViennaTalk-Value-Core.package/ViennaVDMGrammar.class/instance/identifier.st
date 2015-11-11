parsers-symbols
identifier
	^ ((PPPredicateObjectParser on: [ :char | ViennaUnicode isInitialLetter: char ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :char | ViennaUnicode isFollowingLetter: char ] message: 'identifier expected') star)
		flatten trim