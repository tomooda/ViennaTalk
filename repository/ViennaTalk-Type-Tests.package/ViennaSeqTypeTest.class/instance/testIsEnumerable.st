tests
testIsEnumerable
	self deny: seqofnat isEnumerable.
	self deny: (ViennaSeqType with: ViennaType bool) isEnumerable