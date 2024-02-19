Class {
	#name : #ViennaIdentityStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaIdentityStatementNodeTest >> testMaximalType [

	self
		assert: 'skip' asViennaStatementAst maximalType
		equals: ViennaType unit
]
