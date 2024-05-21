Class {
	#name : 'ViennaTraceRepeatPlusPatternNode',
	#superclass : 'ViennaTraceRepeatPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaTraceRepeatPlusPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '+'
]

{ #category : 'accessing' }
ViennaTraceRepeatPlusPatternNode >> label [

	^ 'TraceRepeatPlusPattern'
]

{ #category : 'accessing' }
ViennaTraceRepeatPlusPatternNode >> range [

	^ 1 to: self timesUpperbound
]
