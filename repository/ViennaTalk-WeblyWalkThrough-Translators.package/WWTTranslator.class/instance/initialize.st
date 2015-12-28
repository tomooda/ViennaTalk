initialize-release
initialize
	super initialize.
	vdmDecoder := ViennaVDMValueDecoder new.
	matcherPairs := Array new.
	source := String new