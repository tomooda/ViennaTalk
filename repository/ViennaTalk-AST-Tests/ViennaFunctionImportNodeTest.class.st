Class {
	#name : 'ViennaFunctionImportNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaFunctionImportNodeTest >> testMaximalType [

	self
		assert:
			(('module A exports functions f:nat->nat definitions functions f:nat->nat f(x)==x end A module B imports from A functions f:nat->nat exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType nat -> ViennaType nat.

	self
		assert:
			(('module A exports functions f:nat->nat definitions functions f:nat->nat f(x)==x end A module B imports from A functions f exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType nat -> ViennaType nat.

	self
		should: [
			(('module A exports functions f:nat->nat definitions functions f:nat->nat f(x)==x end A module B imports from A functions f:nat->char exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType ]
		raise: ViennaTypeError
]
