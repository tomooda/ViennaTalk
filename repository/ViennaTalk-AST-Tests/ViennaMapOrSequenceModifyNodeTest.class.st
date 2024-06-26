"
A ViennaMapOrSequenceModifyNodeTest is a test class for testing the behavior of ViennaMapOrSequenceModifyNode
"
Class {
	#name : 'ViennaMapOrSequenceModifyNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'private' }
ViennaMapOrSequenceModifyNodeTest >> assertType1: aViennaType1 type2: aViennaType2 result: aViennaType3 [

	| expr type |
	expr := 'e1 ++ e2' asViennaExpressionAst.
	expr expression1 setMaximalType: aViennaType1.
	expr expression2 setMaximalType: aViennaType2.
	type := expr typecheck.
	self assert: type equals: aViennaType3
]

{ #category : 'tests' }
ViennaMapOrSequenceModifyNodeTest >> testMaximalType [

	| char nat |
	char := ViennaType char.
	nat := ViennaType nat.
	self
		assertType1: (char mapTo: nat)
		type2: (char mapTo: nat)
		result: (char mapTo: nat).
	self
		assertType1: (char mapTo: nat)
		type2: (nat mapTo: char)
		result: (char | nat mapTo: nat | char).
	self
		assertType1: (char mapTo: nat optional)
		type2: (char optional mapTo: nat)
		result: (char optional mapTo: nat optional).
	self assertType1: char seq type2: (nat mapTo: char) result: char seq.
	self
		assertType1: char seq1
		type2: (nat mapTo: nat)
		result: (char | nat) seq1.
	self
		assertType1: char seq
		type2: (nat mapTo: char optional)
		result: char optional seq
]
