Class {
	#name : #ViennaTraceRepeatPlusPatternNode,
	#superclass : #ViennaTraceRepeatPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTraceRepeatPlusPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '+'
]

{ #category : #accessing }
ViennaTraceRepeatPlusPatternNode >> label [

	^ 'TraceRepeatPlusPattern'
]

{ #category : #enumerating }
ViennaTraceRepeatPlusPatternNode >> numbersDo: aBlock [

	1 to: self timesUpperbound do: aBlock
]
