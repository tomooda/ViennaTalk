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

{ #category : #'as yet unclassified' }
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
