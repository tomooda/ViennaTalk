Class {
	#name : #ViennaTraceRepeatOptionalPatternNode,
	#superclass : #ViennaTraceRepeatPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaTraceRepeatOptionalPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty , '?'
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
