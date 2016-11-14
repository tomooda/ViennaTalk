tests
testSpecification
	| spec |
	spec := 'values one = 1;'.
	animation specification: spec copy.
	self assert: animation specification equals: spec.