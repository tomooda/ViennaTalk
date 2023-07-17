Class {
	#name : #ViennaStateDesignatorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaStateDesignatorNode class >> isAbstract [

	^ self = ViennaStateDesignatorNode
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
