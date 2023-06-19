Class {
	#name : #ViennaFieldNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFieldNode class >> identifier: aString equalityAbstraction: aBoolean type: aViennaTypeNode [

	^ (self new: 3)
		  identifier: aString;
		  equalityAbstraction: aBoolean;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #private }
ViennaFieldNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #accessing }
ViennaFieldNode >> equalityAbstraction [

	^ self at: 2
]

{ #category : #accessing }
ViennaFieldNode >> equalityAbstraction: aBoolean [

	self at: 2 put: aBoolean
]

{ #category : #'pretty printing' }
ViennaFieldNode >> formatWith: aViennaAbstractFormatter [

	| name equalityAbstraction type |
	name := self identifier.
	equalityAbstraction := self equalityAbstraction.
	type := aViennaAbstractFormatter format: self type.
	^ (name ifNil: [ '' ] ifNotNil: [
		   name , (equalityAbstraction
			    ifTrue: [ ' :- ' ]
			    ifFalse: [ ' : ' ]) ]) , type
]

{ #category : #accessing }
ViennaFieldNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaFieldNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaFieldNode >> isViennaFieldNode [

	^ true
]

{ #category : #accessing }
ViennaFieldNode >> label [

	^ 'Field'
]

{ #category : #accessing }
ViennaFieldNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaFieldNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
