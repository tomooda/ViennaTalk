Class {
	#name : 'ViennaRecordTypeDefinitionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaRecordTypeDefinitionNodeTest >> testAsMaximalViennaType [

	self
		assert:
		'T :: f1:nat f2:-nat1 int' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType compose: 'T' of: {
					 {
						 'f1'.
						 false.
						 ViennaType nat }.
					 {
						 'f2'.
						 true.
						 ViennaType nat1 }.
					 {
						 nil.
						 false.
						 ViennaType int } })
]

{ #category : 'tests' }
ViennaRecordTypeDefinitionNodeTest >> testMaximalType [

	self
		assert: 'T :: f1:nat f2:-nat1 int' asViennaTypeAst maximalType
		equals: (ViennaType compose: 'T' of: {
					 {
						 'f1'.
						 false.
						 ViennaType nat }.
					 {
						 'f2'.
						 true.
						 ViennaType nat1 }.
					 {
						 nil.
						 false.
						 ViennaType int } })
]
