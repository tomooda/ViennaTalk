Class {
	#name : 'ViennaTypeVariableNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaTypeVariableNodeTest >> testAsMaximalViennaType [

	self
		assert: '@T' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType parametric: '@T')
]
