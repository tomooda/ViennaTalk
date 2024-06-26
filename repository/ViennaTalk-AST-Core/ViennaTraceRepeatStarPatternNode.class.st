Class {
	#name : 'ViennaTraceRepeatStarPatternNode',
	#superclass : 'ViennaTraceRepeatPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaTraceRepeatStarPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '*'
]

{ #category : 'accessing' }
ViennaTraceRepeatStarPatternNode >> label [

	^ 'TraceRepeatStarPattern'
]

{ #category : 'accessing' }
ViennaTraceRepeatStarPatternNode >> range [

	^ 0 to: self timesUpperbound
]
