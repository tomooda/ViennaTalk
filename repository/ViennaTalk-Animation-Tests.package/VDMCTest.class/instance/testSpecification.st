tests
testSpecification
	| spec |
	spec := 'values one = 1;'.
	vdmc specification: spec copy.
	self assert: vdmc specification equals: spec.