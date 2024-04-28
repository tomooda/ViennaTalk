"
A ViennaTypeSynonymNodeTest is a test class for testing the behavior of ViennaTypeSynonymNode
"
Class {
	#name : #ViennaTypeSynonymNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTypeSynonymNodeTest >> testMaximalType [

	self
		assert:
			('types N = int' asViennaDocumentAst resolveIdentifier: 'N')
				maximalType
		equals: ViennaType int.
	self
		assert: ('types N = int inv x == x >= 0' asViennaDocumentAst
				 resolveIdentifier: 'N') maximalType
		equals: ViennaType int.
	self
		should: [
			('types N = B inv x == x >= 0' asViennaDocumentAst
				 resolveIdentifier: 'N') maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('types N = int inv x == 0' asViennaDocumentAst resolveIdentifier:
				 'N') maximalType ]
		raise: ViennaTypeError
]
