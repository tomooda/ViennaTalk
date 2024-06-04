Class {
	#name : 'ViennaImplicitFunctionDefinitionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaImplicitFunctionDefinitionNodeTest >> testMaximalType [

	self
		assert: ('functions f(x:nat) res:nat pre x > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType
		equals: ViennaType nat -> ViennaType nat.
	self
		should: [
			('functions f(x:nat) res:nat pre y > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'f') maximalType ]
		raise: ViennaTypeError
]
