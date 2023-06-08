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

{ #category : #'as yet unclassified' }
ViennaStateDesignatorNode >> isViennaStateDesignatorNode [

	^ true
]
