parsers
jsonObj2
	^ (${ asParser trim
		,
			((PPJsonParser new stringToken , $: asParser trim , jsonPattern)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: $, asParser trim) withoutSeparators , $} asParser trim)
		==> [ :triple | 
			| pairs |
			pairs := triple second.
			WWTTranslationMapMatcher from: (pairs collect: [ :pair | pair first -> pair second ]) asDictionary ]