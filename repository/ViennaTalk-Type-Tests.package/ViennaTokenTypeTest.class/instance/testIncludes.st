tests
testIncludes
	self deny: (token includes: 1.23).
	self assert: (token includes: (ViennaToken with: 1.23))