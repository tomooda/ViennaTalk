parsers-symbols
initialLetter
	^ PPPredicateObjectParser on: [ :char | ViennaUnicode isInitialLetter: char ] message: 'identifier expected'