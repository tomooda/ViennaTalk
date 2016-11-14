initialize-release
initialize
	super initialize.
	parser := ViennaVDMParser new.
	transpiler := ViennaVDM2SmalltalkObject new.
	reader := ViennaReader new.
	writer := ViennaUnquoteWriter new