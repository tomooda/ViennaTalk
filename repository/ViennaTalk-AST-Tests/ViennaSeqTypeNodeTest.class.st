Class {
	#name : #ViennaSeqTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSeqTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'seq of nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat seq
]
