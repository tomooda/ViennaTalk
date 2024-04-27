Class {
	#name : #ViennaUnionTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaUnionTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat|int' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat | ViennaType int
]
