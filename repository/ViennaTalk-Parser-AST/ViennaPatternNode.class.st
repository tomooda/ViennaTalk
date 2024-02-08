Class {
	#name : #ViennaPatternNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#instVars : [
		'maximalType'
	],
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaPatternNode class >> isAbstract [

	^ self = ViennaPatternNode
]

{ #category : #testing }
ViennaPatternNode >> isViennaPatternNode [

	^ true
]

{ #category : #typechecking }
ViennaPatternNode >> maximalType [

	^ maximalType ifNil: [ maximalType := ViennaType unit ]
]

{ #category : #accessing }
ViennaPatternNode >> pattern [

	^ self
]
