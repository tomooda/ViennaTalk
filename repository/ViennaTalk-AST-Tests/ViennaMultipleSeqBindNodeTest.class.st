Class {
	#name : #ViennaMultipleSeqBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaMultipleSeqBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, y, z in seq [1,2,3]'.
	self assert: bind maximalType equals: ViennaType nat1.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType nat1 ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, y, z in seq [1,2.2,nil]'.
	self assert: bind maximalType equals: ViennaType real optional.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType real optional ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, mk_(y, z) in seq [ 1,2,3]'.
	self should: [ bind maximalType ] raise: ViennaTypeError
]
