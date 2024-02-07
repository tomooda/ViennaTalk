"
A ViennaSequenceConcatenateNodeTest is a test class for testing the behavior of ViennaSequenceConcatenateNode
"
Class {
	#name : #ViennaSequenceConcatenateNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSequenceConcatenateNodeTest >> testMaximalType [

	| expr |
	expr := 's1 ^ s2' asViennaExpressionAst.

	expr expression1 maximalType: ViennaType nat seq.
	expr expression2 maximalType: ViennaType nat seq.
	self assert: expr maximalType equals: ViennaType nat seq.

	expr expression1 maximalType: ViennaType nat seq.
	expr expression2 maximalType: ViennaType char seq1.
	self
		assert: expr maximalType
		equals: (ViennaType nat | ViennaType char) seq1.

	expr expression1 maximalType: ViennaType nat seq.
	expr expression2 maximalType: ViennaType nat1 seq.
	self assert: expr maximalType equals: ViennaType nat seq
]
