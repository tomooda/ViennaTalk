Class {
	#name : #ViennaTypeImportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTypeImportNodeTest >> testMaximalType [

	self
		assert:
			(('module A exports types T definitions types T=nat end A module B imports from A types T exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType unit.
	self
		should: [
			(('module A exports types T definitions types T=nat end A module B imports from A types T2 exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType ]
		raise: ViennaTypeError
]
