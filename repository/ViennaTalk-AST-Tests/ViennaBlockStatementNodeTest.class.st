Class {
	#name : #ViennaBlockStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaBlockStatementNodeTest >> testMaximalType [
	self assert: '(skip; skip)' asViennaStatementAst maximalType equals: ViennaType unit.
	self assert: '(dcl x:nat; x := 1)' asViennaStatementAst maximalType equals: ViennaType unit.
	self assert: '(dcl x:nat := 2; x := 1)' asViennaStatementAst maximalType equals: ViennaType unit.
	self should: ['(dcl x:nat := nil; x := 1)' asViennaStatementAst maximalType] raise: ViennaTypeError.
	self should: ['(dcl x:nat; x := nil)' asViennaStatementAst maximalType] raise: ViennaTypeError.
	self should: ['(dcl x:nat := 2; v := 1)' asViennaStatementAst maximalType] raise: ViennaTypeError.
	
]
