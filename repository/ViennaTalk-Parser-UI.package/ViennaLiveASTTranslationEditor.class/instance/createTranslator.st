private
createTranslator
	| parser |
	parser := ViennaVDMParser new.
	^ [ :string | parser document end / parser statement end / parser expression end parse: string ]