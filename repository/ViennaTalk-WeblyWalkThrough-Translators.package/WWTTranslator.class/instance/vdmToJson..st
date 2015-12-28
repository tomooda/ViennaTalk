translating
vdmToJson: aString
	| vdmObj |
	vdmObj := vdmDecoder parse: aString.
	vdmObj isPetitFailure
		ifTrue: [ ^ aString ].
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
					^ NeoJSONWriter toString: (jsonMatcher emit: translatedBinds) ] ].
	^ NeoJSONWriter toString: vdmObj