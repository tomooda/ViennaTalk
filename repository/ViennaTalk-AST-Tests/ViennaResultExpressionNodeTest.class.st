"
A ViennaResultExpressionNodeTest is a test class for testing the behavior of ViennaResultExpressionNode
"
Class {
	#name : #ViennaResultExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaResultExpressionNodeTest >> testMaximalType [

	| spec result |
	spec := 'functions f : nat -> char f(x) == ''a'' post RESULT = ''a'''
		        asViennaDocumentAst.
	result := (spec resolveIdentifier: 'f') post expression1.
	self assert: result maximalType equals: ViennaType char
]
