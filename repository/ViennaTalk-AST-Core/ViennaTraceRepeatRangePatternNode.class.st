Class {
	#name : 'ViennaTraceRepeatRangePatternNode',
	#superclass : 'ViennaTraceRepeatPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'operators' }
ViennaTraceRepeatRangePatternNode class >> from: anInteger to: anotherInteger [

	^ (self new: 2)
		  times1: anInteger;
		  times2: anotherInteger;
		  yourself
]

{ #category : 'operators' }
ViennaTraceRepeatRangePatternNode class >> times: anInteger [

	^ (self new: 1)
		  times1: anInteger;
		  yourself
]

{ #category : 'pretty printing' }
ViennaTraceRepeatRangePatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '{' ++ (self size = 1
		   ifTrue: [ self times1 printString ]
		   ifFalse: [
		   self times1 printString ++ ', ' ++ self times2 printString ])
	  ++ '}'
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> label [

	^ 'TraceRepeatRangePattern'
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> range [

	^ self size = 1
		  ifTrue: [ { self times1 } ]
		  ifFalse: [
		  (self times1 min: self times2) to: (self times1 max: self times2) ]
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> times1 [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> times1: anInteger [

	self at: 1 put: anInteger
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> times2 [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaTraceRepeatRangePatternNode >> times2: anInteger [

	self at: 2 put: anInteger
]
