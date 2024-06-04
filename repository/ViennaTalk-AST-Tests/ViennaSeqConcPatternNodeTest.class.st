"
A ViennaSeqConcPatternNodeTest is a test class for testing the behavior of ViennaSeqConcPatternNode
"
Class {
	#name : 'ViennaSeqConcPatternNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSeqConcPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse: '[1,2,3] ^ m'.
	self assert: pattern typecheck equals: ViennaType any seq1.
	pattern maximalType: ViennaType real seq.
	self assert: pattern typecheck equals: ViennaType real seq1.
	self assert: (pattern collect: #typecheck) equals: {
			ViennaType nat1 seq1.
			ViennaType real seq }
]
