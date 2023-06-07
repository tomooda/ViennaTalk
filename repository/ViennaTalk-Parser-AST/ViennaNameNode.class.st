Class {
	#name : #ViennaNameNode,
	#superclass : #ViennaStateDesignatorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaNameNode class >> isAbstract [

	^ self = ViennaNameNode
]

{ #category : #testing }
ViennaNameNode >> isTypeNode [

	parent notNil and: [ parent isViennaTypeNameNode ]
]

{ #category : #testing }
ViennaNameNode >> isViennaNameNode [

	^ true
]
