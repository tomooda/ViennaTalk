running
setUp
	super setUp.
	bool2nat := ViennaMapType with: ViennaType bool with: ViennaType nat.
	bool2optbool := ViennaMapType with: ViennaType bool with: ViennaType bool optional