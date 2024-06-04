Class {
	#name : 'ViennaOptionalTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaOptionalTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '[nat]' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat optional
]
