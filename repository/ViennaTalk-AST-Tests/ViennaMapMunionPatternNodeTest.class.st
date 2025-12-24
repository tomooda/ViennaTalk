Class {
	#name : 'ViennaMapMunionPatternNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapMunionPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser current pattern end parse:
		           '{(1) |-> (''2'')} munion m'.
	self
		assert: pattern maximalType
		equals: (ViennaType any mapTo: ViennaType any).
	pattern maximalType:
		(ViennaType real mapTo: ViennaType char optional).
	self
		assert: pattern typecheck
		equals: (ViennaType real mapTo: ViennaType char optional).
	self
		assert: pattern pattern1 typecheck
		equals: (ViennaType nat1 mapTo: ViennaType char).
	self
		assert: pattern pattern2 typecheck
		equals: (ViennaType real mapTo: ViennaType char optional).
	self
		assert: pattern maximalType
		equals: (ViennaType real mapTo: ViennaType char optional)
]
