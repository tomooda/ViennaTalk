Class {
	#name : #ViennaTypeVariableNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeVariableNodeTest >> testAsMaximalViennaType [

	self
		should: [ '@T' asViennaTypeAst asMaximalViennaType ]
		raise: Error
]
