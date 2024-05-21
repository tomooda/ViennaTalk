Class {
	#name : 'ViennaTraceRepeatOptionalPatternNode',
	#superclass : 'ViennaTraceRepeatPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaTraceRepeatOptionalPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '?'
]

{ #category : 'accessing' }
ViennaTraceRepeatOptionalPatternNode >> label [

	^ 'TraceRepeatOptionalPattern'
]

{ #category : 'accessing' }
ViennaTraceRepeatOptionalPatternNode >> range [

	^ 0 to: 1
]
