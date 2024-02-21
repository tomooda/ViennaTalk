"
A ViennaExplicitFunctionDefinitionNodeTest is a test class for testing the behavior of ViennaExplicitFunctionDefinitionNode
"
Class {
	#name : #ViennaExplicitFunctionDefinitionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaExplicitFunctionDefinitionNodeTest >> testMaximalType [

	self
		assert: ('functions f:nat->nat f(x) == x pre x > 0 post RESULT > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType
		equals: ViennaType nat -> ViennaType nat.
	self
		assert: ('functions f[@T]:@T->nat f(x) == if x = x then 1 else 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType
		equals: (ViennaType parametric: '@T') -> ViennaType nat.
	self
		assert:
			('functions f:()->nat f() == 1 post RESULT > 0' asViennaDocumentAst
				 resolveIdentifier: 'f') maximalType
		equals: ViennaType unit -> ViennaType nat.
	self
		should: [
			('functions f:nat->nat f(x) == if x = nil then 1 else 2'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType ]
		raise: ViennaTypeError
]
