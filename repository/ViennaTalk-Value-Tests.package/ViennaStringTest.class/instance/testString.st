tests
testString
	self assert: 'abc' viennaString equals: '"abc"'.
	self assert: ('abc', String lf, 'xyz') viennaString equals: '"abc\nxyz"'.
	self assert: ('abc', String cr, 'xyz') viennaString equals: '"abc\rxyz"'