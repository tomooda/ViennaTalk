Class {
	#name : #ViennaMultipleSeqBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMultipleSeqBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, y, z in seq [1,2,3]'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType nat1 ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, y, z in seq [1,2.2,nil]'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	bind patternsDo: [ :pattern |
		self assert: pattern typecheck equals: ViennaType real optional ].
	bind := ViennaVDMParser new multipleBind end parse:
		        'x, mk_(y, z) in seq [ 1,2,3]'.
	self should: [ bind typecheck ] raise: ViennaTypeError
]
