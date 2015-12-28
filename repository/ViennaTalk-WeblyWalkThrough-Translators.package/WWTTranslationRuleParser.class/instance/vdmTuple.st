parsers
vdmTuple
	^ ('mk_' asParser trim , $( asParser trim , (vdmPattern separatedBy: $, asParser trim) withoutSeparators
		, $) asParser trim) ==> [ :array | WWTTranslationArrayMatcher withAll: array third ]