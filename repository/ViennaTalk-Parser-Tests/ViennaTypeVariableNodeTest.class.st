Class {
	#name : #ViennaTypeVariableNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeVariableNodeTest >> testAsMaximalViennaType [

	self
		assert: '@T' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType parametric: '@T')
]
