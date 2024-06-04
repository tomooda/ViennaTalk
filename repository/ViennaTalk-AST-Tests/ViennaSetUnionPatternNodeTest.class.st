"
A ViennaSetUnionPatternNodeTest is a test class for testing the behavior of ViennaSetUnionPatternNode
"
Class {
	#name : 'ViennaSetUnionPatternNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSetUnionPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse: '{1,2,3} union s'.
	self assert: pattern typecheck equals: ViennaType any set1.
	pattern maximalType: ViennaType real set.
	self assert: pattern typecheck equals: ViennaType real set1.
	self assert: (pattern collect: #typecheck) equals: {
			ViennaType nat1 set1.
			ViennaType real set }
]
