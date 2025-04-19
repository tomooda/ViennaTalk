Class {
	#name : 'ViennaEpiLog',
	#superclass : 'Object',
	#traits : 'TComparable + THiDePersistency',
	#classTraits : 'TComparable classTrait + THiDePersistency classTrait',
	#instVars : [
		'prev',
		'diffSetFromPred',
		'diffSetFromPrev'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLog class >> after: aViennaEpiLog [

	^ self new
		  hideStorage: (aViennaEpiLog ifNotNil: #hideStorage);
		  prev: aViennaEpiLog;
		  yourself
]

{ #category : 'class access' }
ViennaEpiLog class >> classFor: aString [

	self allSubclassesDo: [ :class |
		(class isAbstract not and: [ aString = class metadataName ])
			ifTrue: [ ^ class ] ].
	^ nil
]

{ #category : 'testing' }
ViennaEpiLog class >> isAbstract [

	^ self = ViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLog class >> metadataName [

	^ self subclassResponsibility
]

{ #category : 'instance creation' }
ViennaEpiLog class >> vanilla [

	^ ViennaVanillaEpiLog new
		  hideStorage: ViennaHiDeStorage memory;
		  yourself
]

{ #category : 'comparing' }
ViennaEpiLog >> < aViennaEpiLog [

	^ self timestamp < aViennaEpiLog timestamp
]

{ #category : 'comparing' }
ViennaEpiLog >> = aComparable [

	^ self == aComparable
]

{ #category : 'converting' }
ViennaEpiLog >> artifactTimeline [

	^ ViennaEpiLogArtifactTimelineEnumerator current arrayFrom: self
]

{ #category : 'accessing' }
ViennaEpiLog >> basicPred [

	^ prev
]

{ #category : 'accessing' }
ViennaEpiLog >> basicPred: aViennaEpiLog [
]

{ #category : 'accessing' }
ViennaEpiLog >> comment [

	^ hideMetadata at: 'comment' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
ViennaEpiLog >> comment: aString [

	(aString isNil or: [ aString isEmpty ])
		ifTrue: [ hideMetadata removeKey: 'comment' ifAbsent: [  ] ]
		ifFalse: [ hideMetadata at: 'comment' put: aString asString ]
]

{ #category : 'defaults' }
ViennaEpiLog >> defaultComment [

	^ ''
]

{ #category : 'accessing' }
ViennaEpiLog >> diffSetFromPred [

	^ diffSetFromPred ifNil: [
		  diffSetFromPred := ViennaNodeDiffSet
			                     from: (self pred
					                      ifNotNil: #specification
					                      ifNil: [ ViennaModularDocumentNode new ])
			                     to: self specification ]
]

{ #category : 'accessing' }
ViennaEpiLog >> diffSetFromPrev [

	^ diffSetFromPrev ifNil: [
		  diffSetFromPrev := ViennaNodeDiffSet
			                     from: (prev
					                      ifNotNil: #specification
					                      ifNil: [ ViennaModularDocumentNode new ])
			                     to: self specification ]
]

{ #category : 'testing' }
ViennaEpiLog >> hasChangeAt: aString module: anotherString [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> hasChangeAtModule: aString [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> hasSpecificationChange [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> hasStateChange [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> hasTag: aString [

	^ hideMetadata hasTag: aString
]

{ #category : 'comparing' }
ViennaEpiLog >> hash [
	"Hash must be redefined whenever = is redefined."

	^ self identityHash
]

{ #category : 'hideho-testing' }
ViennaEpiLog >> hideIsAutoExpirable [

	^ false
]

{ #category : 'hideho-operations' }
ViennaEpiLog >> hideLoad: aFileReference [

	
]

{ #category : 'hideho-operations' }
ViennaEpiLog >> hideMetadataLoaded [

	hideMetadata
		at: 'prev'
		ifPresent: [ :id | prev := hideStorage chronicleAt: id ]
]

{ #category : 'hideho-operations' }
ViennaEpiLog >> hideRemove [

	self isRemovable ifTrue: [
		| newPrev newPred |
		newPrev := prev.
		newPred := self basicPred.
		hideStorage chronicle do: [ :epiLog |
			| changed |
			changed := false.
			epiLog prev == self ifTrue: [
				epiLog prev: newPrev.
				changed := true ].
			epiLog basicPred == self ifTrue: [
				epiLog basicPred: newPred.
				changed := true ].
			changed ifTrue: [ hideStorage chronicleSave: epiLog ] ].
		hideStorage chronicleRemove: self ]
]

{ #category : 'hideho-operations' }
ViennaEpiLog >> hideSave: aFileReference [
	
]

{ #category : 'hideho-operations' }
ViennaEpiLog >> hideUpdateMetadataStorage: aHiDeStorage [

	hideMetadata at: 'class' put: self metadataName.
	prev ifNotNil: [
		prev hideStorage = aHiDeStorage ifFalse: [
			aHiDeStorage chronicleSave: prev ].
		hideMetadata at: 'prev' put: prev hideMetadata identity ]
]

{ #category : 'initialization' }
ViennaEpiLog >> initialize [

	super initialize.
	self initializeHideMetadata.
	self comment: self defaultComment
]

{ #category : 'testing' }
ViennaEpiLog >> isAbstractModificationEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isEvaluationEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isExecutionClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isExecutionEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isInitializationEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isLoadingEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isModificationEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isPredEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaEpiLog >> isRemovable [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaEpiLog >> isRevertionEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isSemanticClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isSyntacticClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isVanillaEpiLog [

	^ false
]

{ #category : 'accessing' }
ViennaEpiLog >> metadataName [

	^ self class metadataName
]

{ #category : 'instance creation' }
ViennaEpiLog >> newEvaluation: aString [

	^ ViennaEvaluationEpiLog after: self expression: aString
]

{ #category : 'instance creation' }
ViennaEpiLog >> newExecution: aString state: aDictionary [

	^ ViennaExecutionEpiLog
		  after: self
		  statement: aString
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : 'instance creation' }
ViennaEpiLog >> newInitialization: aDictionary [

	^ ViennaInitializationEpiLog after: self state: aDictionary
]

{ #category : 'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode [

	^ self newLoading: aViennaModularDocumentNode after: self
]

{ #category : 'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode after: aViennaEpiLog [

	^ self
		  newLoading: aViennaModularDocumentNode
		  state: self state
		  after: aViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode state: aDictionary after: aViennaEpiLog [

	^ ViennaLoadingEpiLog
		  after: aViennaEpiLog
		  specification: aViennaModularDocumentNode
		  state: aDictionary
]

{ #category : 'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode [

	^ self newModification: aViennaModularDocumentNode state: self state
]

{ #category : 'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode state: aDictionary [

	^ ViennaModificationEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: aDictionary
]

{ #category : 'instance creation' }
ViennaEpiLog >> newRevertion: aViennaEpiLog [

	^ ViennaRevertionEpiLog
		  after: self
		  destination: aViennaEpiLog revertDestination
]

{ #category : 'instance creation' }
ViennaEpiLog >> newVanilla: aViennaModularDocumentNode state: aDictionary [

	^ ViennaVanillaEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: aDictionary
]

{ #category : 'accessing' }
ViennaEpiLog >> pred [

	^ self basicPred ifNotNil: [ :pred |
		  pred isPredEpiLog
			  ifTrue: [ pred ]
			  ifFalse: [ pred pred ] ]
]

{ #category : 'accessing' }
ViennaEpiLog >> prev [

	^ prev
]

{ #category : 'accessing' }
ViennaEpiLog >> prev: aViennaEpiLog [

	prev := aViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLog >> revertDestination [

	^ self
]

{ #category : 'accessing' }
ViennaEpiLog >> specification [

	^ prev
		  ifNotNil: #specification
		  ifNil: [ ViennaModularDocumentNode new ]
]

{ #category : 'accessing' }
ViennaEpiLog >> state [

	^ prev ifNotNil: #state ifNil: [ Dictionary new ]
]

{ #category : 'accessing' }
ViennaEpiLog >> state: aDictionary [

	
]

{ #category : 'accessing' }
ViennaEpiLog >> tags [

	^ hideMetadata tags
]

{ #category : 'accessing' }
ViennaEpiLog >> timestamp [

	^ hideMetadata timestamp
]

{ #category : 'converting' }
ViennaEpiLog >> userTimeline [

	^ ViennaEpiLogUserTimelineEnumerator current arrayFrom: self
]
