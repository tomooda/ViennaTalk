Class {
	#name : 'ViennaTypeStructExportNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaTypeStructExportNodeTest >> testMaximalType [

	self
		assert: ('module A exports types struct T definitions types T = nat end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType
		equals: ViennaType unit.
	self
		should: [
			('module A exports types struct T definitions types T2 = nat end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType ]
		raise: ViennaTypeError
]
