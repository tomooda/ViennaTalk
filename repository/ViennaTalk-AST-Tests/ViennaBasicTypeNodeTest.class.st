Class {
	#name : 'ViennaBasicTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaBasicTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat.
	self
		assert: '?' asViennaTypeAst asMaximalViennaType
		equals: ViennaType any
]
