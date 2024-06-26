Class {
	#name : 'ViennaTraceRepeatPatternNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaTraceRepeatPatternNode class >> isAbstract [

	^ self = ViennaTraceRepeatPatternNode
]

{ #category : 'accessing' }
ViennaTraceRepeatPatternNode class >> timesUpperbound [

	^ 16
]

{ #category : 'private' }
ViennaTraceRepeatPatternNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'private' }
ViennaTraceRepeatPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'typechecking' }
ViennaTraceRepeatPatternNode >> maximalType [

	^ ViennaType unit
]

{ #category : 'accessing' }
ViennaTraceRepeatPatternNode >> range [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaTraceRepeatPatternNode >> timesUpperbound [

	^ self class timesUpperbound
]
