Class {
	#name : #ViennaSeqTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSeqTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'seq of nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat seq
]
