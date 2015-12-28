parsers
jsonObj1
	^ (${ asParser trim , var , $: asParser trim , jsonPattern , $} asParser trim)
		==> [ :quin | 
			| key value |
			key := quin second.
			value := quin fourth.
			WWTTranslationDictionaryMatcher key: key value: value ]