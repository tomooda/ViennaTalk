Class {
	#name : 'ViennaValueImportNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaValueImportNodeTest >> testMaximalType [

	self
		assert:
			(('module A exports values v:nat definitions values v:nat = 1 end A module B imports from A values v:nat exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType nat1.
	self
		assert:
			(('module A exports values v:nat definitions values v:nat = 1 end A module B imports from A values v exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType nat1.
	self
		should: [
			(('module A exports values v:nat definitions values v:nat = 1 end A module B imports from A values v:char exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType ]
		raise: ViennaTypeError
]
