translating
vdmToJson: vdmObj
	matcherPairs
		do: [ :pair | 
			| vdmMatcher jsonMatcher |
			vdmMatcher := pair first.
			jsonMatcher := pair second.
			(vdmMatcher accept: vdmObj)
				ifNotNil: [ :binds | 
					| translatedBinds |
					translatedBinds := Dictionary new.
					binds keysAndValuesDo: [ :var :val | translatedBinds at: var put: (self vdmToJson: val) ].
					^ jsonMatcher emit: translatedBinds ] ].
	^ vdmObj