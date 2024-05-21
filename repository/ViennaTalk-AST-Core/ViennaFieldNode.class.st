Class {
	#name : 'ViennaFieldNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaFieldNode class >> identifier: aString equalityAbstraction: aBoolean type: aViennaTypeNode [

	^ (self new: 3)
		  identifier: aString;
		  equalityAbstraction: aBoolean;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : 'converting' }
ViennaFieldNode >> asMaximalViennaType [

	^ Array
		  with: self identifier
		  with: self equalityAbstraction
		  with: self type asMaximalViennaType
]

{ #category : 'converting' }
ViennaFieldNode >> asMaximalViennaTypeAny [

	^ Array
		  with: self identifier
		  with: self equalityAbstraction
		  with: ViennaType any
]

{ #category : 'private' }
ViennaFieldNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'accessing' }
ViennaFieldNode >> equalityAbstraction [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaFieldNode >> equalityAbstraction: aBoolean [

	self at: 2 put: aBoolean
]

{ #category : 'pretty printing' }
ViennaFieldNode >> formatWith: aViennaAbstractFormatter [

	| name equalityAbstraction type |
	name := self identifier.
	equalityAbstraction := self equalityAbstraction.
	type := aViennaAbstractFormatter format: self type.
	^ (name ifNil: [ aViennaAbstractFormatter empty ] ifNotNil: [
		   name ++ (equalityAbstraction
			    ifTrue: [ ' :- ' ]
			    ifFalse: [ ' : ' ]) ]) ++ type
]

{ #category : 'private' }
ViennaFieldNode >> freeIdentifiersExcept: aSet do: aBlock [

	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaFieldNode >> identifier [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaFieldNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : 'testing' }
ViennaFieldNode >> isViennaFieldNode [

	^ true
]

{ #category : 'accessing' }
ViennaFieldNode >> label [

	^ 'Field'
]

{ #category : 'typechecking' }
ViennaFieldNode >> maximalType [

	^ self type typecheck
]

{ #category : 'accessing' }
ViennaFieldNode >> type [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaFieldNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
