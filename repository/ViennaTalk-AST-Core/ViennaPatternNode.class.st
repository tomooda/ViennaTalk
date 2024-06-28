Class {
	#name : 'ViennaPatternNode',
	#superclass : 'ViennaPatternBindNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaPatternNode class >> isAbstract [

	^ self = ViennaPatternNode
]

{ #category : 'converting' }
ViennaPatternNode >> asExpression [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaPatternNode >> isViennaPatternNode [

	^ true
]

{ #category : 'accessing' }
ViennaPatternNode >> pattern [

	^ self
]
