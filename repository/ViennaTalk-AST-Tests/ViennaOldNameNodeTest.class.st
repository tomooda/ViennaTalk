"
A ViennaOldNameNodeTest is a test class for testing the behavior of ViennaOldNameNode
"
Class {
	#name : #ViennaOldNameNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaOldNameNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:int init s == s = mk_S(0) end values v:real = 1'
		        asViennaDocumentAst.
	self
		assert: ('x~' asViennaExpressionAst
				 parent: spec;
				 maximalType)
		equals: ViennaType int.
	self
		should: [
			'w~' asViennaExpressionAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
