"
A ViennaMapOrSequenceReferenceNodeTest is a test class for testing the behavior of ViennaMapOrSequenceReferenceNode
"
Class {
	#name : #ViennaMapOrSequenceReferenceNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaMapOrSequenceReferenceNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:seq of int y:int init s == s = mk_S([0], 0) end'
		        asViennaDocumentAst.
	self
		assert: ('x(0) := 1' asViennaStatementAst
				 parent: spec;
				 yourself) stateDesignator maximalType
		equals: ViennaType int.
	self
		should: [
			('y(0) := 1' asViennaStatementAst
				 parent: spec;
				 yourself) stateDesignator maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('x(nil) := 1' asViennaStatementAst
				 parent: spec;
				 yourself) stateDesignator maximalType ]
		raise: ViennaTypeError
]
