running
setUp
	super setUp.
	natBool := ViennaProductType with: ViennaType nat with: ViennaType bool.
	quoteBool := ViennaProductType with: (ViennaType quote: #QUOTE) with: ViennaType bool