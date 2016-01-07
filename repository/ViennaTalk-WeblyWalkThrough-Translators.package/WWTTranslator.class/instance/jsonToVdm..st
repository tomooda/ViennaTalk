translating
jsonToVdm: jsonObj
	matcherPairs
		do: [ :pair | 
			| vdmMatcher jsonMatcher |
			vdmMatcher := pair first.
			jsonMatcher := pair second.
			(jsonMatcher accept: jsonObj)
				ifNotNil: [ :binds | 
					| translatedBinds |
					translatedBinds := Dictionary new.
					binds keysAndValuesDo: [ :var :val | translatedBinds at: var put: (self jsonToVdm: val) ].
					^ (vdmMatcher emit: translatedBinds)  ] ].
	^ jsonObj 