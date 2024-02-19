Class {
	#name : #ViennaDefStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaDefStatementNodeTest >> testMaximalType [

	self
		assert:
		'def x = 1; y = x; x = 0.1 in skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		assert:
			'def x:int = 1; y = x; x:real = 0.1 in skip' asViennaStatementAst
				maximalType
		equals: ViennaType unit
]
