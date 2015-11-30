tests
testDo
	self should: [ bool +> bool do: [ :f |  ] ] raise: ShouldNotImplement