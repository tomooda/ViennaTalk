Class {
	#name : #ViennaUnaryTypeConstructorNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaUnaryTypeConstructorNode class >> isAbstract [

	^ self = ViennaUnaryTypeConstructorNode
]

{ #category : #'instance creation' }
ViennaUnaryTypeConstructorNode class >> type: aViennaTypeNode [

	^ (self new: 1)
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #private }
ViennaUnaryTypeConstructorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaUnaryTypeConstructorNode >> isViennaUnaryTypeConstructorNode [

	^ true
]

{ #category : #accessing }
ViennaUnaryTypeConstructorNode >> type [

	^ self at: 1
]

{ #category : #accessing }
ViennaUnaryTypeConstructorNode >> type: aViennaTypeNode [

	self at: 1 put: aViennaTypeNode
]
