Class {
	#name : #ViennaUnitTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaUnitTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '()' asViennaTypeAst asMaximalViennaType
		equals: ViennaType unit
]
