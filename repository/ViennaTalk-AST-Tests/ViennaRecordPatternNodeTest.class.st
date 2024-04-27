Class {
	#name : #ViennaRecordPatternNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaRecordPatternNodeTest >> testMaximalType [

	| spec pattern r |
	spec := 'types R:: x:real y:real' asViennaDocumentAst.
	pattern := (ViennaVDMParser new pattern end parse: 'mk_R((2), a)')
		           parent: spec;
		           yourself.
	r := (spec resolveIdentifier: 'R') asMaximalViennaType.
	self assert: r isCompositeType.
	self assert: r constructorName equals: 'R'.
	self assert: pattern typecheck equals: r.
	self assert: (pattern patternList collect: #typecheck) equals: {
			ViennaType nat1.
			ViennaType any }.
	pattern maximalType: r.
	self assert: pattern typecheck equals: r.
	self assert: (pattern patternList collect: #typecheck) equals: {
			ViennaType nat1.
			ViennaType real }
]
