parsers-symbols
followingLetter
	^ PPPredicateObjectParser on: [ :char | ViennaUnicode isFollowingLetter: char ] message: 'identifier expected'