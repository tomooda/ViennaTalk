parsers-symbols
followingLetter
	^ PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected'