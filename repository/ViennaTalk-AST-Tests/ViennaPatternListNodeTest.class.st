Class {
	#name : #ViennaPatternListNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaPatternListNodeTest >> testMaximalType [

	| p |
	p := ViennaVDMParser new patternList end parse: 'mk_(x,y), xs^ys'.
	self
		assert: p typecheck
		equals: ViennaType any * ViennaType any | ViennaType any seq.
	p maximalType: ViennaType char seq1.
	self assert: p typecheck equals: ViennaType char seq1.
	p maximalType: ViennaType char set.
	self should: [ p typecheck: ViennaType any ] raise: ViennaTypeError
]
