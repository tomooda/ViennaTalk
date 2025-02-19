Class {
	#name : 'ViennaModificationEpiLog',
	#superclass : 'ViennaAbstractModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

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

	self hasSpecificationChange ifFalse: [ ^ true ].
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
