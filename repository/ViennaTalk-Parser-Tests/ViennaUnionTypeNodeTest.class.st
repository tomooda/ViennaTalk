Class {
	#name : #ViennaUnionTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaUnionTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat|int' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat | ViennaType int
]
