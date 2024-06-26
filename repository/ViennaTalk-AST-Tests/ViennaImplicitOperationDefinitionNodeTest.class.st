Class {
	#name : 'ViennaImplicitOperationDefinitionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaImplicitOperationDefinitionNodeTest >> testMaximalType [

	self
		assert:
			('state S of v1:nat v2:[char] end operations op(x:nat) res:nat ext rd v1:nat wr v2:[char] pre x > 0 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'op') maximalType
		equals: ViennaType nat ==> ViennaType nat.
	self
		assert:
			('state S of v1:nat v2:[char] end operations op(x:nat) res:nat ext rd v1 wr v2 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'op') maximalType
		equals: ViennaType nat ==> ViennaType nat.
	self
		should: [
			('state S of v1:nat v2:[char] end operations op(x:nat) res:nat == return x ext rd v1 wr v3 post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('state S of v1:nat v2:[char] end operations op(x:nat) res:nat == return x ext rd v1 wr v2:int post res > 0'
				 asViennaDocumentAst resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError
]
