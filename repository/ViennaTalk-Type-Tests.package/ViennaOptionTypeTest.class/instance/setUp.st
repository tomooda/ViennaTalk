running
setUp
	super setUp.
	optionNat := ViennaOptionType with: ViennaType nat.
	optionQuote := ViennaOptionType with: (ViennaType quote: #'<QUOTE>')