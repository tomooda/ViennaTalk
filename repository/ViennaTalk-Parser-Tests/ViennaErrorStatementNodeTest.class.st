Class {
	#name : #ViennaErrorStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaErrorStatementNodeTest >> testMaximalType [

	self
		assert: 'error' asViennaStatementAst maximalType
		equals: ViennaType unit
]
