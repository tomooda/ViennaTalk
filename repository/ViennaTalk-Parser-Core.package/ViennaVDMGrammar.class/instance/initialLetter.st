parsers-symbols
initialLetter
	^ PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected'