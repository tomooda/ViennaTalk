Class {
	#name : #ViennaMultipleTypeBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaMultipleTypeBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new multipleBind end parse: 'x, y, z : nat1'.
	self assert: bind maximalType equals: ViennaType nat1.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType nat1 ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, y, z : [real]'.
	self assert: bind maximalType equals: ViennaType real optional.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType real optional ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, mk_(y, z) : [real]'.
	self should: [ bind maximalType ] raise: ViennaTypeError
]
