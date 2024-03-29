Class {
	#name : #ViennaEpiLog,
	#superclass : #Object,
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#instVars : [
		'timestamp',
		'comment',
		'prev'
	],
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #'instance creation' }
ViennaEpiLog class >> after: aViennaEpiLog [

	^ self new
		  prev: aViennaEpiLog;
		  yourself
]

{ #category : #testing }
ViennaEpiLog class >> isAbstract [

	^ self = ViennaEpiLog
]

{ #category : #'instance creation' }
ViennaEpiLog class >> vanilla [

	^ ViennaVanillaEpiLog new
]

{ #category : #comparing }
ViennaEpiLog >> < aViennaEpiLog [

	^ timestamp < aViennaEpiLog timestamp
]

{ #category : #comparing }
ViennaEpiLog >> = aComparable [

	^ super = aComparable
]

{ #category : #accessing }
ViennaEpiLog >> comment [

	^ comment
]

{ #category : #accessing }
ViennaEpiLog >> comment: anObject [

	comment := anObject
]

{ #category : #converting }
ViennaEpiLog >> constructionLine [

	^ Array streamContents: [ :stream |
		  | epiLog |
		  epiLog := self.
		  [ epiLog notNil ] whileTrue: [
			  stream nextPut: epiLog.
			  epiLog := epiLog pred ] ]
]

{ #category : #defaults }
ViennaEpiLog >> defaultComment [

	^ ''
]

{ #category : #testing }
ViennaEpiLog >> hasChangeAt: aString module: anotherString [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> hasChangeAtModule: aString [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> hasSpecificationChange [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> hasStateChange [

	^ false
]

{ #category : #initialization }
ViennaEpiLog >> initialize [

	super initialize.
	comment := self defaultComment.
	timestamp := DateAndTime now
]

{ #category : #testing }
ViennaEpiLog >> isEvaluationEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isExecutionEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isInitializationEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isLoadEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isModificationEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isRevertionEpiLog [

	^ false
]

{ #category : #testing }
ViennaEpiLog >> isVanillaEpiLog [

	^ false
]

{ #category : #'instance creation' }
ViennaEpiLog >> newEvaluation: aString [

	^ ViennaEvaluationEpiLog after: self expression: aString
]

{ #category : #'instance creation' }
ViennaEpiLog >> newExecution: aString state: aDictionary [

	^ ViennaExecutionEpiLog
		  after: self
		  statement: aString
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : #'instance creation' }
ViennaEpiLog >> newInitialization: aDictionary [

	^ ViennaInitializationEpiLog after: self state: aDictionary
]

{ #category : #'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode [

	^ ViennaLoadingEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
]

{ #category : #'instance creation' }
ViennaEpiLog >> newLoading: aViennaModularDocumentNode state: aDictionary [

	^ ViennaLoadingEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : #'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode [

	^ ViennaModificationEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
]

{ #category : #'instance creation' }
ViennaEpiLog >> newModification: aViennaModularDocumentNode state: aDictionary [

	^ ViennaModificationEpiLog
		  after: self
		  specification: aViennaModularDocumentNode
		  state: (self state = aDictionary
				   ifTrue: [ nil ]
				   ifFalse: [ aDictionary ])
]

{ #category : #'instance creation' }
ViennaEpiLog >> newRevertion: aViennaEpiLog [

	^ ViennaRevertionEpiLog
		  after: self
		  destination: aViennaEpiLog revertDestination
]

{ #category : #accessing }
ViennaEpiLog >> pred [

	^ prev ifNotNil: [
		  prev isRevertionEpiLog
			  ifTrue: [ prev pred ]
			  ifFalse: [ prev ] ]
]

{ #category : #accessing }
ViennaEpiLog >> prev [

	^ prev
]

{ #category : #accessing }
ViennaEpiLog >> prev: aViennaEpiLog [

	prev := aViennaEpiLog
]

{ #category : #accessing }
ViennaEpiLog >> revertDestination [

	^ self
]

{ #category : #accessing }
ViennaEpiLog >> specification [

	^ prev
		  ifNotNil: #specification
		  ifNil: [ ViennaModularDocumentNode new ]
]

{ #category : #accessing }
ViennaEpiLog >> state [

	^ prev ifNotNil: #state ifNil: [ Dictionary new ]
]

{ #category : #accessing }
ViennaEpiLog >> state: aDictionary [

	
]

{ #category : #converting }
ViennaEpiLog >> timeLine [

	^ Array streamContents: [ :stream |
		  | epiLog |
		  epiLog := self.
		  [ epiLog notNil ] whileTrue: [
			  stream nextPut: epiLog.
			  epiLog := epiLog prev ] ]
]

{ #category : #accessing }
ViennaEpiLog >> timestamp [

	^ timestamp
]
