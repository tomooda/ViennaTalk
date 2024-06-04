Class {
	#name : 'ViennaSeqBindNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSeqBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new bind end parse: 'x in seq [1,2,3]'.
	self assert: bind maximalType equals: ViennaType nat1.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind := ViennaVDMParser new bind end parse: 'x in seq [1,2.2,nil]'.
	self assert: bind maximalType equals: ViennaType real optional.
	self assert: bind pattern typecheck equals: ViennaType real optional.
	bind := ViennaVDMParser new multipleBind end parse:
		        'mk_(y, z) in seq [1,2,3]'.
	self should: [ bind maximalType ] raise: ViennaTypeError
]
