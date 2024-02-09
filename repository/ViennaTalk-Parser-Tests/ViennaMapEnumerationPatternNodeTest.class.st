"
A ViennaMapEnumerationPatternNodeTest is a test class for testing the behavior of ViennaMapEnumerationPatternNode
"
Class {
	#name : #ViennaMapEnumerationPatternNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapEnumerationPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse:
		           '{a |-> b, (1) |-> (''2'')}'.
	self
		assert: pattern typecheck
		equals: (ViennaType any mapTo: ViennaType any).
	pattern maximalType:
		(ViennaType real mapTo: ViennaType char optional).
	self
		assert: pattern typecheck
		equals: (ViennaType real mapTo: ViennaType char optional).
	self
		assert: pattern first keyPattern typecheck
		equals: ViennaType real.
	self
		assert: pattern first valuePattern typecheck
		equals: ViennaType char optional.
	pattern := ViennaVDMParser new pattern end parse: '{|->}'.
	self
		assert: pattern typecheck
		equals: (ViennaType unit mapTo: ViennaType unit)
]
