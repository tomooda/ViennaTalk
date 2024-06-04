"
A ViennaSetEnumPatternNodeTest is a test class for testing the behavior of ViennaSetEnumPatternNode
"
Class {
	#name : 'ViennaSetEnumPatternNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSetEnumPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse: '{1,2,3}'.
	self assert: pattern typecheck equals: ViennaType nat1 set1.
	pattern := ViennaVDMParser new pattern end parse: '{1,x}'.
	self assert: pattern typecheck equals: ViennaType any set1.
	pattern maximalType: ViennaType real set.
	self assert: pattern typecheck equals: ViennaType real set1.
	self assert: (pattern collect: #typecheck) equals: {
			ViennaType nat1.
			ViennaType real }
]
