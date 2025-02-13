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
ViennaEvaluationEpiLog class >> metadataName [

	^ 'Evaluation'
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> expression [

	expression ifNil: [ self hideLoad ].
	^ expression
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> expression: aString [

	expression := aString
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	super hideLoad: aFileReference storage: aHiDeStorage.
	aFileReference / 'expression.txt' ifExists: [ :ref |
		expression := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideSave: aFileReference storage: aHiDeStorage [

	super hideSave: aFileReference storage: aHiDeStorage.
	expression ifNotNil: [
		(aFileReference / 'expression.txt')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: expression ] ]
]

{ #category : 'testing' }
ViennaEvaluationEpiLog >> isEvaluationEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaEvaluationEpiLog >> printOn: aStream [

	aStream
		nextPutAll: 'Eval ';
		nextPutAll: self expression
]
