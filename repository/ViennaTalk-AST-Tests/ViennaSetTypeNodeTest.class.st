Class {
	#name : 'ViennaSetTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSetTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'set of nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat set
]
