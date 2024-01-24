Class {
	#name : #ViennaSeq1TypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSeq1TypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'seq1 of nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat seq1
]
