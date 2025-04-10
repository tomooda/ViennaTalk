Class {
	#name : 'ViennaNameNode',
	#superclass : 'ViennaStateDesignatorNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaNameNode class >> isAbstract [

	^ self = ViennaNameNode
]

{ #category : 'converting' }
ViennaNameNode >> asGlobalName [

	^ self subclassResponsibility
]

{ #category : 'accessing-definitions' }
ViennaNameNode >> definition [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaNameNode >> isViennaNameNode [

	^ true
]

{ #category : 'typechecking' }
ViennaNameNode >> maximalType [

	maximalType ifNotNil: [ ^ maximalType ].
	^ self resolve ifNotNil: #typecheck ifNil: [
		  ViennaTypeError
			  on: self
			  signal: 'Unresolved local name: ' , self source ]
]
