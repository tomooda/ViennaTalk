"
A ViennaStateDefinitionNodeTest is a test class for testing the behavior of ViennaStateDefinitionNode
"
Class {
	#name : #ViennaStateDefinitionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaStateDefinitionNodeTest >> testMaximalType [

	self
		assert:
			(('types N = nat state S of x:N inv mk_S(a) == a > 0 init s == s = mk_S(0) end'
				  asViennaDocumentAst resolveIdentifier: 'S')
				 maximalType;
				 fieldList) first typecheck
		equals: ViennaType nat
]
