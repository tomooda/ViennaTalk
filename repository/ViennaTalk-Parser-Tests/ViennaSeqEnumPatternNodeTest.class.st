"
A ViennaSeqEnumPatternNodeTest is a test class for testing the behavior of ViennaSeqEnumPatternNode
"
Class {
	#name : #ViennaSeqEnumPatternNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSeqEnumPatternNodeTest >> testMaximalType [

	| pattern |
	pattern := ViennaVDMParser new pattern end parse: '[1,2,3]'.
	self assert: pattern typecheck equals: ViennaType nat1 seq1.
	pattern := ViennaVDMParser new pattern end parse: '[1,x]'.
	self assert: pattern typecheck equals: ViennaType any seq1.
	pattern maximalType: ViennaType real seq.
	self assert: pattern typecheck equals: ViennaType real seq1.
	self assert: (pattern collect: #typecheck) equals: {
			ViennaType nat1.
			ViennaType real }
]
