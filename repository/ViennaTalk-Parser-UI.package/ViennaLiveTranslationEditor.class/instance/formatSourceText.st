VDM manipulations
formatSourceText
	^ sourceText text: (ViennaVDMParser new format: sourceText text asString) 