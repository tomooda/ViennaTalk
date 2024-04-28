Class {
	#name : #ViennaCallStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaCallStatementNodeTest >> testMaximalType [

	| spec |
	spec := 'operations op1: nat * char ==> () op1(n, c) == skip; op2:nat ==> () op2(x) == skip; op3:()==>() op3(x) == skip; op4:nat==>nat op4(x) == return x'
		        asViennaDocumentAst.
	self
		assert: ('op1(1, ''a'')' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		assert: ('op2(1)' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		assert: ('op3()' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		assert: ('op4(1)' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType nat.
	self
		should: [
			'op1(1)' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'op2(nil)' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'op3(1)' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
