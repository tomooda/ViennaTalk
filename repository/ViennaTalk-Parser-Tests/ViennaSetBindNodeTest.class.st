Class {
	#name : #ViennaSetBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSetBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new bind end parse: 'x in set {1,2,3}'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind := ViennaVDMParser new bind end parse: 'x in set {1,2.2,nil}'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	self assert: bind pattern typecheck equals: ViennaType real optional.
	bind := ViennaVDMParser new multipleBind end parse:
		        'mk_(y, z) in set {1,2,3}'.
	self should: [ bind typecheck ] raise: ViennaTypeError
]
