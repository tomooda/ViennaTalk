tests
testIsEnumerable
	self deny: (bool +> bool) isEnumerable.
	self deny: (nat +> nat) isEnumerable