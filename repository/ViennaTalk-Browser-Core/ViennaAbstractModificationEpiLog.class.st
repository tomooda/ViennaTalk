Class {
	#name : 'ViennaAbstractModificationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#state => HiDePersistencySlot loader: #hideLoadState',
		'#specification => HiDePersistencySlot loader: #hideLoadSpecification'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaAbstractModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode [

	^ self
		  after: aViennaEpiLog
		  specification: aViennaModularDocumentNode
		  state: Dictionary new
]

{ #category : 'instance creation' }
ViennaAbstractModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode state: aDictionary [

	^ (self after: aViennaEpiLog)
		  specification: aViennaModularDocumentNode;
		  state: aDictionary;
		  yourself
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog class >> isAbstract [

	^ self = ViennaAbstractModificationEpiLog
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog >> hasChangeAt: aString module: anotherString [

	^ ((self specification moduleNamed: anotherString) ifNotNil: [ :m |
		   m resolveIdentifier: aString ])
	  ~=
		  ((prev ifNotNil: [ prev specification moduleNamed: anotherString ])
			   ifNotNil: [ :m | m resolveIdentifier: aString ])
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog >> hasChangeAtModule: aString [

	^ (self specification moduleNamed: aString)
	  ~= (prev ifNotNil: [ prev specification moduleNamed: aString ])
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog >> hasSpecificationChange [

	^ prev isNil or: [ prev specification ~= self specification ]
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog >> hasStateChange [

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self
		hideLoadSpecification: aFileReference;
		hideLoadState: aFileReference
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideLoadSpecification [

	self hideBaseDirectoryDo: [ :ref | self hideLoadSpecification: ref ]
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideLoadSpecification: aFileReference [

	aFileReference / 'source.vdmsl' ifExists: [ :ref |
		ref readStreamDo: [ :stream |
			specification := ref contents asViennaDocumentAst ] ]
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideLoadState [

	self hideBaseDirectoryDo: [ :ref | self hideLoadState: ref ]
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideLoadState: aFileReference [

	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaAbstractModificationEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	specification ifNotNil: [
		(aFileReference / 'source.vdmsl')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: specification source ] ].
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'initialization' }
ViennaAbstractModificationEpiLog >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'testing' }
ViennaAbstractModificationEpiLog >> isAbstractModificationEpiLog [

	^ true
]

{ #category : 'accessing' }
ViennaAbstractModificationEpiLog >> specification [

	^ specification ifNil: [ prev specification ]
]

{ #category : 'accessing' }
ViennaAbstractModificationEpiLog >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode
]

{ #category : 'accessing' }
ViennaAbstractModificationEpiLog >> state [

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : 'accessing' }
ViennaAbstractModificationEpiLog >> state: aDictionary [

	state := aDictionary
]
