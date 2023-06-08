Class {
	#name : #ViennaAbstractFunctionTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
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

{ #category : #'as yet unclassified' }
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
