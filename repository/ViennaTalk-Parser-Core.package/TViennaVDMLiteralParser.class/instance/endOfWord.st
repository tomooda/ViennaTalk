parsers-literals
endOfWord
	^ (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') not