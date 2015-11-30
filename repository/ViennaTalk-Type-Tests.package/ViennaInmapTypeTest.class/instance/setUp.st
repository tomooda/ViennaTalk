running
setUp
	super setUp.
	bool2nat := ViennaInmapType with: ViennaType bool with: ViennaType nat.
	bool2optbool := ViennaInmapType with: ViennaType bool with: ViennaType bool optional