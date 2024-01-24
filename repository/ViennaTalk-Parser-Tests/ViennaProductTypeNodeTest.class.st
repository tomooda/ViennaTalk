Class {
	#name : #ViennaProductTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaProductTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat*int' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat * ViennaType int
]
