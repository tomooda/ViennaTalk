Class {
	#name : #ViennaQuoteTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaQuoteTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '<quote>' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType quote: 'quote')
]
