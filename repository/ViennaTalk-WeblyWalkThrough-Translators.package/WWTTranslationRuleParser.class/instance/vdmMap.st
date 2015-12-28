parsers
vdmMap
	^ (${ asParser trim , vdmPattern , '|->' asParser trim , vdmPattern , $} asParser trim)
		==> [ :array | 
			| key value |
			key := array second.
			value := array fourth.
			WWTTranslationDictionaryMatcher key: key value: value ]