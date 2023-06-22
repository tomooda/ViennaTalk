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

{ #category : #converting }
ViennaNameNode >> asGlobalName [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaNameNode >> isTypeNode [

	parent notNil and: [ parent isViennaTypeNameNode ]
]

{ #category : #testing }
ViennaNameNode >> isViennaNameNode [

	^ true
]

{ #category : #'accessing-definitions' }
ViennaNameNode >> resolve [

	^ self subclassResponsibility
]
