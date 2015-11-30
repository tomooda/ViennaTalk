tests
testIsEnumerable
	self deny: seq1ofnat isEnumerable.
	self deny: (ViennaSeq1Type with: ViennaType bool) isEnumerable