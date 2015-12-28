parsers-literals
quoteLiteral
	^ ($< asParser
		,
			((PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
				, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star)
		, $> asParser) flatten trim