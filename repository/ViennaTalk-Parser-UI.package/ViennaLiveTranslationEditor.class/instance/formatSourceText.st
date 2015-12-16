VDM manipulations
formatSourceText
	^ sourceText text: (ViennaVDMParser new document end parse: sourceText text asString) format