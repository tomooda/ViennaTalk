"
A ViennaTypeNameExportNodeTest is a test class for testing the behavior of ViennaTypeNameExportNode
"
Class {
	#name : #ViennaTypeNameExportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeNameExportNodeTest >> testMaximalType [

	self
		assert: ('module A exports types T definitions types T = nat end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType
		equals: ViennaType unit.
	self
		should: [
			('module A exports types T definitions types T2 = nat end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType ]
		raise: ViennaTypeError
]
