Extension { #name : #ViennaTrapStatementNodeTest }

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaTrapStatementNodeTest >> testMaximalType [

	self
		assert: 'trap p with skip in skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		assert:
			('operations op:()==>real op() == trap p:nat with return p in skip'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat
]

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaTrapStatementNodeTest >> testSliceWith [

	| spec op statement slicer |
	spec := '
module A
exports all
definitions
state S of
    x : nat
    y : nat
    z : nat
init s == s = mk_S(0, 0, 0)
end
operations
    op : () ==> ()
    op() == trap p with x := p in exit z;
end A
' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          operation: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: (spec moduleNamed: 'A');
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda equals: {
			((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
