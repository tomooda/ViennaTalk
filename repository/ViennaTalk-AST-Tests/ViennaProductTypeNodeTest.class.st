Class {
	#name : 'ViennaProductTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaProductTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat*int' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat * ViennaType int
]
