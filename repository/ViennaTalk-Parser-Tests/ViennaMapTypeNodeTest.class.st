Class {
	#name : #ViennaMapTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'map nat to int' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType nat mapTo: ViennaType int)
]
