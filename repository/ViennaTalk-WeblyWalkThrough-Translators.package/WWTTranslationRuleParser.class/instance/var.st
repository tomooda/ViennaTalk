parsers
var
	^ ($$ asParser , (PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star)
		flatten trim ==> [ :name | WWTTranslationBindingMatcher variable: name ]