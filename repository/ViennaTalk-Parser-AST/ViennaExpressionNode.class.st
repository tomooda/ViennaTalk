Class {
	#name : #ViennaExpressionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#instVars : [
		'type'
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
ViennaExpressionNode >> type [

	^ type ifNil: [ type := self typecheck ]
]

{ #category : #typechecking }
ViennaExpressionNode >> type: aViennaType [

	type := aViennaType
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck [

	^ self typecheck: ViennaType any
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck: aViennaType [

	^ self subclassResponsibility
]

{ #category : #typechecking }
ViennaExpressionNode >> untype [

	type := nil
]
