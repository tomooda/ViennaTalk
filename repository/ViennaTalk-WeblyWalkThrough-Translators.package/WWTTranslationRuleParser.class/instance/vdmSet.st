parsers
vdmSet
	^ (${ asParser trim , vdmPattern , $} asParser trim) ==> [ :triple | WWTTranslationSetMatcher with: triple second ]