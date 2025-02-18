Class {
	#name : 'ViennaEvaluationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#expression => HiDePersistencySlot loader: #hideLoadExpression'
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

	^ expression
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> expression: aString [

	expression := aString
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self hideLoadExpression: aFileReference
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoadExpression [

	self hideBaseDirectoryDo: [ :ref | self hideLoadExpression: ref ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoadExpression: aFileReference [

	aFileReference / 'expression.txt' ifExists: [ :ref |
		expression := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	expression ifNotNil: [
		(aFileReference / 'expression.txt')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: expression ] ]
]

{ #category : 'initialization' }
ViennaEvaluationEpiLog >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'testing' }
ViennaEvaluationEpiLog >> isEvaluationEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaEvaluationEpiLog >> isRemovable [

	^ true
]

{ #category : 'printing' }
ViennaEvaluationEpiLog >> printOn: aStream [

	aStream
		nextPutAll: 'Eval ';
		nextPutAll: self expression
]
