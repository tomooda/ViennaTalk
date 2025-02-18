Class {
	#name : 'ViennaModificationEpiLog',
	#superclass : 'ViennaAbstractModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode [

	^ self
		  after: aViennaEpiLog
		  specification: aViennaModularDocumentNode
		  state: Dictionary new
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
ViennaModificationEpiLog >> isExecutionClosureMember [

	^ true
]

{ #category : 'testing' }
ViennaModificationEpiLog >> isModificationEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaModificationEpiLog >> isRemovable [

	(self hasSpecificationChange not and: [ self hasStateChange not ])
		ifTrue: [ ^ true ].
	hideStorage chronicle do: [ :epiLog |
		epiLog prev == self ifTrue: [
			epiLog isModificationEpiLog ifFalse: [ ^ false ] ].
		epiLog basicPred == self ifTrue: [
			epiLog isModificationEpiLog ifFalse: [ ^ false ] ] ].
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

	state := aDictionary
]
