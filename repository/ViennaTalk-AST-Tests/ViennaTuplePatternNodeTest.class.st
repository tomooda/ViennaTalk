Class {
	#name : #ViennaTuplePatternNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTuplePatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse: 'mk_(x, y, (1))'.
	self
		assert: pattern typecheck
		equals: ViennaType any * ViennaType any * ViennaType nat1.
	self assert: (pattern patternList collect: #typecheck) equals: {
			ViennaType any.
			ViennaType any.
			ViennaType nat1 }.
	pattern maximalType:
		ViennaType real * ViennaType char * ViennaType int.
	self
		assert: pattern typecheck
		equals: ViennaType real * ViennaType char * ViennaType nat1.
	self assert: (pattern patternList collect: #typecheck) equals: {
			ViennaType real.
			ViennaType char.
			ViennaType nat1 }
]
