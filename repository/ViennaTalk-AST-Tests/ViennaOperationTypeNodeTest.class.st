Class {
	#name : 'ViennaOperationTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaOperationTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat*int==>bool' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat * ViennaType int ==> ViennaType bool.
	self
		assert: 'nat==>bool' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat ==> ViennaType bool
]
