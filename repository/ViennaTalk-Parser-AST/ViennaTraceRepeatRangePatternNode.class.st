Class {
	#name : #ViennaTraceRepeatRangePatternNode,
	#superclass : #ViennaTraceRepeatPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #operators }
ViennaTraceRepeatRangePatternNode class >> from: anInteger to: anotherInteger [

	^ self new
		  times1: anInteger;
		  times2: anotherInteger;
		  yourself
]

{ #category : #operators }
ViennaTraceRepeatRangePatternNode class >> times: anInteger [

	^ self new
		  times1: anInteger;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceRepeatRangePatternNode >> formatWith: aViennaAbstractFormatter [

	^ '{' , self times1 printString
	  ,
	  (self times2 ifNotNil: [ :n | ', ' , n printString ] ifNil: [ '' ])
	  , '}'
]

{ #category : #accessing }
ViennaTraceRepeatRangePatternNode >> label [

	^ 'TraceRepeatRangePattern'
]

{ #category : #enumerating }
ViennaTraceRepeatRangePatternNode >> numbersDo: aBlock [

	self times2
		ifNotNil: [ :n |
		(self times1 min: n) to: (self times1 max: n) do: aBlock ]
		ifNil: [ aBlock value: self times1 ]
]

{ #category : #accessing }
ViennaTraceRepeatRangePatternNode >> times1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceRepeatRangePatternNode >> times1: anInteger [

	self at: 1 put: anInteger
]

{ #category : #accessing }
ViennaTraceRepeatRangePatternNode >> times2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaTraceRepeatRangePatternNode >> times2: anInteger [

	self at: 2 put: anInteger
]
