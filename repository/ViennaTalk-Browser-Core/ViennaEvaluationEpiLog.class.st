Class {
	#name : 'ViennaEvaluationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#expression => HiDePersistencySlot loader: #hideLoadExpression',
		'#state => HiDePersistencySlot loader: #hideLoadState'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEvaluationEpiLog class >> after: aViennaEpiLog expression: aString state: aDictionary [

	^ (self after: aViennaEpiLog)
		  expression: aString;
		  state: aDictionary;
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

{ #category : 'testing' }
ViennaEvaluationEpiLog >> hasStateChange [

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self
		hideLoadExpression: aFileReference;
		hideLoadState: aFileReference
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
ViennaEvaluationEpiLog >> hideLoadState [

	self hideBaseDirectoryDo: [ :ref | self hideLoadState: ref ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideLoadState: aFileReference [

	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaEvaluationEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	expression ifNotNil: [
			(aFileReference / 'expression.txt')
				ensureDelete;
				writeStreamDo: [ :stream | stream nextPutAll: expression ] ].
	state ifNotNil: [
			(aFileReference / 'state.json')
				ensureDelete;
				writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
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

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> state [

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : 'accessing' }
ViennaEvaluationEpiLog >> state: aDictionary [

	state := aDictionary
]
