Class {
	#name : 'ViennaEpiLog',
	#superclass : 'Object',
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#instVars : [
		'timestamp',
		'comment',
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
		  prev: aViennaEpiLog;
		  yourself
]

{ #category : 'testing' }
ViennaEpiLog class >> isAbstract [

	^ self = ViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLog class >> vanilla [

	^ ViennaVanillaEpiLog new
]

{ #category : 'comparing' }
ViennaEpiLog >> < aViennaEpiLog [

	^ timestamp < aViennaEpiLog timestamp
]

{ #category : 'comparing' }
ViennaEpiLog >> = aComparable [

	^ self == aComparable
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

	^ comment
]

{ #category : 'accessing' }
ViennaEpiLog >> comment: anObject [

	comment := anObject
]

{ #category : 'converting' }
ViennaEpiLog >> constructionLine [

	^ ViennaEpiLogConstructionLineEnumerator current arrayFrom: self
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
			                     from: (self prev
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

{ #category : 'comparing' }
ViennaEpiLog >> hash [
	"Hash must be redefined whenever = is redefined."

	^ self identityHash
]

{ #category : 'initialization' }
ViennaEpiLog >> initialize [

	super initialize.
	comment := self defaultComment.
	timestamp := DateAndTime now
]

{ #category : 'testing' }
ViennaEpiLog >> isEvaluationEpiLog [

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
ViennaEpiLog >> isLoadEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaEpiLog >> isModificationEpiLog [

	^ false
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

	^ ViennaLoadingEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
]

{ #category : 'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode state: aDictionary [

	^ ViennaLoadingEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : 'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode [

	^ ViennaModificationEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
]

{ #category : 'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode state: aDictionary [

	^ ViennaModificationEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : 'instance creation' }
ViennaEpiLog >> newRevertion: aViennaEpiLog [

	^ ViennaRevertionEpiLog
		  after: self
		  destination: aViennaEpiLog revertDestination
]

{ #category : 'accessing' }
ViennaEpiLog >> pred [

	^ self basicPred ifNotNil: [ :pred |
		  pred isRevertionEpiLog
			  ifTrue: [ pred pred ]
			  ifFalse: [ pred ] ]
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

{ #category : 'converting' }
ViennaEpiLog >> timeLine [

	^ ViennaEpiLogTimeLineEnumerator current arrayFrom: self
]

{ #category : 'accessing' }
ViennaEpiLog >> timestamp [

	^ timestamp
]
