Class {
	#name : #ViennaLogicalEquivalenceNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaLogicalEquivalenceNodeTest >> testTypecheck [

	self
		assert: ('true <=> false' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'3 <=> 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
