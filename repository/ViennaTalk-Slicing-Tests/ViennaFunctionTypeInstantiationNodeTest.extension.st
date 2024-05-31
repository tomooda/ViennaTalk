Extension { #name : 'ViennaFunctionTypeInstantiationNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaFunctionTypeInstantiationNodeTest >> testSliceWith [

	| spec op statement slicer |
	spec := '
module A
exports all
definitions
state S of
	x : nat
	y : nat
	z : nat
init s == s = mk_S(0,0,0)
end
types
	T = nat inv t == t < z
functions
	f[@T] : @T -> @T
	f(a) == a
operations
	op : () ==> ()
	op() == x := f[T](y);
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: statement;
				           resolve) }.
	statement sliceWith: slicer.
	self
		assert: slicer agenda asSet
		equals: { ((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve) } asSet
]
