"
A ViennaExtendedExplicitFunctionDefinitionNodeTest is a test class for testing the behavior of ViennaExtendedExplicitFunctionDefinitionNode
"
Class {
	#name : 'ViennaExtendedExplicitFunctionDefinitionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaExtendedExplicitFunctionDefinitionNodeTest >> testMaximalType [

	self
		assert: ('functions f(x:nat) res:nat == x pre x > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType
		equals: ViennaType nat -> ViennaType nat.
	self
		assert: ('functions sum(xs:seq of real) res:real == cases xs: [x]^rest -> x+sum(rest), others -> 0 end post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'sum') maximalType
		equals: ViennaType real seq -> ViennaType real.
	self
		should: [('functions f(x:nat) res:nat == x pre y > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType]
		raise: ViennaTypeError
]
