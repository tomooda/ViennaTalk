Class {
	#name : 'ViennaQuoteTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaQuoteTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '<quote>' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType quote: 'quote')
]
