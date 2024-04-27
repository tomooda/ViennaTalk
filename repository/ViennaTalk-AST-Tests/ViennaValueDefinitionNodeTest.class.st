"
A ViennaValueDefinitionNodeTest is a test class for testing the behavior of ViennaValueDefinitionNode
"
Class {
	#name : #ViennaValueDefinitionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaValueDefinitionNodeTest >> testMaximalType [

	self
		assert: ('mk_(x, y)' asViennaExpressionAst
				 parent:
					 ('values mk_(x, y):int*[char] = mk_(1, ''a'')'
						  asViennaDocumentAst
						  typecheck;
						  yourself);
				 yourself) maximalType
		equals: ViennaType nat1 * ViennaType char.
	self
		assert: ('mk_(x, y)' asViennaExpressionAst
				 parent: ('values mk_(x, y) = mk_(1, ''a'')' asViennaDocumentAst
						  typecheck;
						  yourself);
				 yourself) maximalType
		equals: ViennaType nat1 * ViennaType char.
	self
		should: [
			'values mk_(x, y):int*char = mk_(1, nil)' asViennaDocumentAst
				maximalType ]
		raise: ViennaTypeError
]
