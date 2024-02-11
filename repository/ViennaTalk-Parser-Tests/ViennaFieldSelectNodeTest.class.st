Class {
	#name : #ViennaFieldSelectNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaFieldSelectNodeTest >> testMaximalType [

	| spec point point3d expr |
	spec := 'types Point:: x:real y:real; Point3D:: x:int y:int z:int'
		        asViennaDocumentAst.
	point := (spec resolveIdentifier: 'Point') asMaximalViennaType.
	point3d := (spec resolveIdentifier: 'Point3D') asMaximalViennaType.
	expr := 'f.x' asViennaExpressionAst
		        parent: spec;
		        yourself.
	expr expression maximalType:
		point | point3d | (ViennaType quote: 'quote').
	self assert: expr maximalType equals: ViennaType real.
	expr := 'f.z' asViennaExpressionAst
		        parent: spec;
		        yourself.
	expr expression maximalType:
		point | point3d | (ViennaType quote: 'quote').
	self assert: expr maximalType equals: ViennaType int.
	expr := 'f.w' asViennaExpressionAst
		        parent: spec;
		        yourself.
	expr expression maximalType:
		point | point3d | (ViennaType quote: 'quote').
	self should: [ expr typecheck ] raise: ViennaTypeError
]
