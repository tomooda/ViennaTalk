Class {
	#name : #ViennaAbstractFunctionTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaAbstractFunctionTypeNode class >> argumentType: aViennaTypeNode1 returnType: aViennaTypeNode2 [

	^ (self new: 2)
		  argumentType: aViennaTypeNode1;
		  returnType: aViennaTypeNode2;
		  yourself
]

{ #category : #testing }
ViennaAbstractFunctionTypeNode class >> isAbstract [

	^ self = ViennaAbstractFunctionTypeNode
]

{ #category : #accessing }
ViennaAbstractFunctionTypeNode >> argumentType [

	^ self at: 1
]

{ #category : #accessing }
ViennaAbstractFunctionTypeNode >> argumentType: aViennaTypeNode [

	self at: 1 put: aViennaTypeNode
]

{ #category : #accessing }
ViennaAbstractFunctionTypeNode >> argumentTypes [

	| argType |
	argType := self argumentType.
	^ argType isViennaProductTypeNode
		  ifTrue: [ argType asArray ]
		  ifFalse: [ Array with: argType ]
]

{ #category : #private }
ViennaAbstractFunctionTypeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self argumentType freeIdentifiersExcept: aSet do: aBlock.
	self returnType freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaAbstractFunctionTypeNode >> isViennaAbstractFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaAbstractFunctionTypeNode >> returnType [

	^ self at: 2
]

{ #category : #accessing }
ViennaAbstractFunctionTypeNode >> returnType: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
