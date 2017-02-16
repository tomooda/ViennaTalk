running
setUp
	super setUp.
	natBool := ViennaUnionType with: ViennaType nat with: ViennaType bool.
	quoteBool := ViennaUnionType with: (ViennaType quote: #'QUOTE') with: ViennaType bool