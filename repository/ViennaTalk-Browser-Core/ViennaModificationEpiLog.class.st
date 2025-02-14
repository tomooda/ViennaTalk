Class {
	#name : 'ViennaModificationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#specification => HiDePersistencySlot',
		'#state => HiDePersistencySlot'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode [

	^ (self after: aViennaEpiLog)
		  specification: aViennaModularDocumentNode;
		  yourself
]

{ #category : 'instance creation' }
ViennaModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode state: aDictionary [

	^ (self after: aViennaEpiLog)
		  specification: aViennaModularDocumentNode;
		  state: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ViennaModificationEpiLog class >> metadataName [

	^ 'Modification'
]

{ #category : 'testing' }
ViennaModificationEpiLog >> hasChangeAt: aString module: anotherString [

	^ ((self specification moduleNamed: anotherString) ifNotNil: [ :m |
		   m resolveIdentifier: aString ])
	  ~=
		  ((prev ifNotNil: [ prev specification moduleNamed: anotherString ])
			   ifNotNil: [ :m | m resolveIdentifier: aString ])
]

{ #category : 'testing' }
ViennaModificationEpiLog >> hasChangeAtModule: aString [

	^ (self specification moduleNamed: aString)
	  ~= (prev ifNotNil: [ prev specification moduleNamed: aString ])
]

{ #category : 'testing' }
ViennaModificationEpiLog >> hasSpecificationChange [

	^ prev isNil or: [ prev specification ~= self specification ]
]

{ #category : 'testing' }
ViennaModificationEpiLog >> hasStateChange [

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : 'hideho-operations' }
ViennaModificationEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	super hideLoad: aFileReference storage: aHiDeStorage.
	aFileReference / 'source.vdmsl' ifExists: [ :ref |
		ref readStreamDo: [ :stream |
			specification := ref contents asViennaDocumentAst ] ].
	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaModificationEpiLog >> hideSave: aFileReference storage: aHiDeStorage [

	super hideSave: aFileReference storage: aHiDeStorage.
	specification ifNotNil: [
		(aFileReference / 'source.vdmsl')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: specification source ] ].
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'testing' }
ViennaModificationEpiLog >> isModificationEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaModificationEpiLog >> isSemanticClosureMember [

	^ true
]

{ #category : 'testing' }
ViennaModificationEpiLog >> isSyntacticClosureMember [

	^ true
]

{ #category : 'printing' }
ViennaModificationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Edit'
]

{ #category : 'accessing' }
ViennaModificationEpiLog >> specification [

	^ specification
]

{ #category : 'accessing' }
ViennaModificationEpiLog >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode
]

{ #category : 'accessing' }
ViennaModificationEpiLog >> state [

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : 'accessing' }
ViennaModificationEpiLog >> state: aDictionary [

	state ~= aDictionary ifTrue: [ state := aDictionary ]
]
