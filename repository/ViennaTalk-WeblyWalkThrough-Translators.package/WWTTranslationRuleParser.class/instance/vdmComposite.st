parsers
vdmComposite
	| identifier |
	identifier := (PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star.
	^ ('mk_' asParser , (identifier , ($` asParser , identifier) optional) flatten , $( asParser trim
		, (vdmPattern separatedBy: $, asParser trim) withoutSeparators , $) asParser trim)
		==> [ :array | 
			| constructor args |
			constructor := array second.
			args := array fourth.
			WWTTranslationCompositeMatcher constructor: constructor withAll: args ]