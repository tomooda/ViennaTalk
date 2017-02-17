initialize-release
initialize
	super initialize.
	parser := ViennaVDMParser new.
	reader := ViennaReader new.
	writer := ViennaUnquoteWriter new