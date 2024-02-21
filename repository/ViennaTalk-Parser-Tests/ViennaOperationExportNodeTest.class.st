Class {
	#name : #ViennaOperationExportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaOperationExportNodeTest >> testMaximalType [

	self
		assert: ('module A exports operations op:()==>() definitions operations op:()==>() op()==skip end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType
		equals: ViennaType unit.
	self
		should: [
			('module A exports operations op:()==>nat definitions operations op:()==>() op()==skip end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType ]
		raise: ViennaTypeError
]
