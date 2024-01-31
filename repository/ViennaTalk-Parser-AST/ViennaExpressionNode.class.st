Class {
	#name : #ViennaExpressionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#instVars : [
		'maximalType'
	],
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExpressionNode class >> isAbstract [

	^ self = ViennaExpressionNode
]

{ #category : #private }
ViennaExpressionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #testing }
ViennaExpressionNode >> isViennaExpressionNode [
	^ true
]

{ #category : #typechecking }
ViennaExpressionNode >> maximalType [

	^ maximalType ifNil: [ maximalType := self typecheck ]
]

{ #category : #typechecking }
ViennaExpressionNode >> maximalType: aViennaType [

	maximalType := aViennaType
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck [

	^ self typecheck: ViennaType any
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck: aViennaType [

	maximalType ifNotNil: [
		(maximalType isCompatibleWith: aViennaType) ifTrue: [ ^ maximalType ] ].
	^ self subclassResponsibility
]
