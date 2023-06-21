Class {
	#name : #ViennaResolveIdentifierTest,
	#superclass : #TestCase,
	#instVars : [
		'modularDocument',
		'flatDocument'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #utilities }
ViennaResolveIdentifierTest >> moduleA [
	^ modularDocument moduleNamed: 'A'
]

{ #category : #utilities }
ViennaResolveIdentifierTest >> moduleB [

	^ modularDocument moduleNamed: 'B'
]

{ #category : #running }
ViennaResolveIdentifierTest >> setUp [

	modularDocument := ViennaVDMParser new document parse: '
module A
imports from B types tb renamed tb1; values vb:t renamed vb1; functions fb:nat->nat renamed fb1; operations ob:()==>() renamed ob1
exports all
definitions
types
	t = nat
values
	v = 1
functions
	f : nat -> nat
	f(x) == x
state Sa of
	a : nat
init s == s = mk_Sa(0)
end
operations
	o:() ==> ()
	o() == skip;
end A
module B
exports all
definitions
types
	tb = nat
values
	vb = 1
functions
	fb : nat -> nat
	fb(x) == x
operations
	ob : () ==> ()
	ob() == skip
end B
' trim.
	flatDocument := ViennaVDMParser new document parse: '
types
	t = nat
values
	v = 1
functions
	f : nat -> nat
	f(x) == x
state Sa of
	a : nat
init s == s = mk_Sa(0)
end
operations
	o:() ==> ()
	o() == skip;
' trim
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveImportedFunction [

	| node |
	node := self moduleA deepResolveIdentifier: 'fb1'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'fb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveImportedOperation [

	| node |
	node := self moduleA deepResolveIdentifier: 'ob1'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'ob'.
	self assert: node module identifier equals: 'B'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveImportedType [

	| node |
	node := self moduleA deepResolveIdentifier: 'tb1'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 'tb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveImportedValue [

	| node |
	node := self moduleA deepResolveIdentifier: 'vb1'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'vb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalFunction [

	| node |
	node := self moduleA deepResolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalFunctionParameter [

	| node |
	node := self moduleA deepResolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalOperation [

	| node |
	node := self moduleA deepResolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalStateVariable [

	| node |
	node := self moduleA deepResolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalType [

	| node |
	node := self moduleA deepResolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testDeepResolveLocalValue [

	| node |
	node := self moduleA deepResolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatFunction [

	| node |
	node := flatDocument resolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatFunctionParameter [

	| node |
	node := flatDocument resolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatOperation [

	| node |
	node := flatDocument resolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatStateVariable [

	| node |
	node := flatDocument resolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatType [

	| node |
	node := flatDocument resolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveFlatValue [

	| node |
	node := flatDocument resolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveImportedFunction [

	| node |
	node := self moduleA resolveIdentifier: 'fb1'.
	self assert: node isViennaFunctionImportNode.
	self assert: node identifier equals: 'fb'.
	self assert: node rename identifier equals: 'fb1'.
	node := self moduleA resolveIdentifier: 'fb'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveImportedOperation [

	| node |
	node := self moduleA resolveIdentifier: 'ob1'.
	self assert: node isViennaOperationImportNode.
	self assert: node identifier equals: 'ob'.
	self assert: node rename identifier equals: 'ob1'.
	node := self moduleA resolveIdentifier: 'ob'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveImportedType [

	| node |
	node := self moduleA resolveIdentifier: 'tb1'.
	self assert: node isViennaTypeImportNode.
	self assert: node identifier equals: 'tb'.
	self assert: node rename identifier equals: 'tb1'.
	node := self moduleA resolveIdentifier: 'tb'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveImportedValue [

	| node |
	node := self moduleA resolveIdentifier: 'vb1'.
	self assert: node isViennaValueImportNode.
	self assert: node identifier equals: 'vb'.
	self assert: node rename identifier equals: 'vb1'.
	node := self moduleA resolveIdentifier: 'vb'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalFunction [

	| node |
	node := self moduleA resolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalFunctionParameter [

	| node |
	node := self moduleA resolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalOperation [

	| node |
	node := self moduleA resolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalStateVariable [

	| node |
	node := self moduleA resolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalType [

	| node |
	node := self moduleA resolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #tests }
ViennaResolveIdentifierTest >> testResolveLocalValue [

	| node |
	node := self moduleA resolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]
