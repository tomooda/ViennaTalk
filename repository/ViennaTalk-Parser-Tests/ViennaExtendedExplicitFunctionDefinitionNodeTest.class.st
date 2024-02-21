"
A ViennaExtendedExplicitFunctionDefinitionNodeTest is a test class for testing the behavior of ViennaExtendedExplicitFunctionDefinitionNode
"
Class {
	#name : #ViennaExtendedExplicitFunctionDefinitionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaExtendedExplicitFunctionDefinitionNodeTest >> testMaximalType [

	self
		assert: ('functions f(x:nat) res:nat == x pre x > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType
		equals: ViennaType nat -> ViennaType nat.
	self
		should: [('functions f(x:nat) res:nat == x pre y > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType]
		raise: ViennaTypeError
]
