private
createTranslator
	| parser |
	parser := ViennaVDMParser new.
	^ parser document end / parser statement end / parser expression end