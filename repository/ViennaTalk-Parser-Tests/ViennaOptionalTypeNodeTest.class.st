Class {
	#name : #ViennaOptionalTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaOptionalTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '[nat]' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat optional
]
