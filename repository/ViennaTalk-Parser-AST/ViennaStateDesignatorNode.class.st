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
