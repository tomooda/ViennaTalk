Class {
	#name : #ViennaFunctionExportNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaFunctionExportNodeTest >> testMaximalType [

	self
		assert: ('module A exports functions f:nat->nat definitions functions f:nat->nat f(x)==x end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType
		equals: ViennaType unit.
	self
		should: [
			('module A exports functions f:nat->int definitions functions f:nat->nat f(x)==x end A'
				 asViennaDocumentAst moduleNamed: 'A') exportDefinition first
				first first maximalType ]
		raise: ViennaTypeError
]
