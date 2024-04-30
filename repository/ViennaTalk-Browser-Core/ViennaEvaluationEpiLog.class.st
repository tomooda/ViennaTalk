Class {
	#name : 'ViennaEvaluationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'expression'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEvaluationEpiLog class >> after: aViennaEpiLog expression: aString [

	^ (self after: aViennaEpiLog)
		  expression: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> expression [

	^ expression
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> expression: aString [

	expression := aString
]

{ #category : 'testing' }
ViennaEvaluationEpiLog >> isEvaluationEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaEvaluationEpiLog >> printOn: aStream [

	aStream
		nextPutAll: 'Eval ';
		nextPutAll: expression
]
