Class {
	#name : #ViennaTraceRepeatOptionalPatternNode,
	#superclass : #ViennaTraceRepeatPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTraceRepeatOptionalPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '?'
]

{ #category : #accessing }
ViennaTraceRepeatOptionalPatternNode >> label [

	^ 'TraceRepeatOptionalPattern'
]

{ #category : #enumerating }
ViennaTraceRepeatOptionalPatternNode >> numbersDo: aBlock [

	aBlock
		value: 0;
		value: 1
]
