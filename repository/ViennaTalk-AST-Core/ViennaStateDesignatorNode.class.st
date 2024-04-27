Class {
	#name : #ViennaStateDesignatorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaStateDesignatorNode class >> isAbstract [

	^ self = ViennaStateDesignatorNode
]

{ #category : #testing }
ViennaStateDesignatorNode >> isAssignable [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaStateDesignatorNode >> isViennaStateDesignatorNode [

	^ true
]

{ #category : #'accessing-definitions' }
ViennaStateDesignatorNode >> localResolve [

	^ self subclassResponsibility
]

{ #category : #'accessing-definitions' }
ViennaStateDesignatorNode >> resolve [

	^ self subclassResponsibility
]
