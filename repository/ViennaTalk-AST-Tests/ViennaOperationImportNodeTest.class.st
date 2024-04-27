Class {
	#name : #ViennaOperationImportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaOperationImportNodeTest >> testMaximalType [

	self
		assert:
			(('module A exports operations op:()==>() definitions operations op:()==>() op()==skip end A module B imports from A operations op:()==>() exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType
		equals: ViennaType unit.
	self
		should: [
			(('module A exports operations op:()==>() definitions operations op:()==>() op()==skip end A module B imports from A operations op:()==>nat exports all definitions end B'
				  asViennaDocumentAst moduleNamed: 'B')
				 importDefinitionAtModuleIdentifier: 'A') second first first
				maximalType ]
		raise: ViennaTypeError
]
