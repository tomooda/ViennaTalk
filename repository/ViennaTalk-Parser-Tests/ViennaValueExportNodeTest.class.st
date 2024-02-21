Class {
	#name : #ViennaValueExportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaValueExportNodeTest >> testMaximalType [

	self
		assert: ('module A exports values v:nat definitions values v:nat = 1 end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType
		equals: ViennaType unit.
	self
		should: [
			('module A exports values v:char definitions values v:nat = 1 end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType ]
		raise: ViennaTypeError
]
