Class {
	#name : 'ViennaSpecificationModificationEpiLog',
	#superclass : 'ViennaAbstractModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaSpecificationModificationEpiLog class >> metadataName [

	^ 'Modification'
]

{ #category : 'testing' }
ViennaSpecificationModificationEpiLog >> isExecutionClosureMember [

	^ true
]

{ #category : 'testing' }
ViennaSpecificationModificationEpiLog >> isRemovable [

	self hasSpecificationChange ifFalse: [ ^ true ].
	hideStorage chronicle do: [ :epiLog |
		epiLog prev == self ifTrue: [
			epiLog isSpecificationModificationEpiLog ifFalse: [ ^ false ] ].
		epiLog basicPred == self ifTrue: [
			epiLog isSpecificationModificationEpiLog ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : 'testing' }
ViennaSpecificationModificationEpiLog >> isSemanticClosureMember [

	^ true
]

{ #category : 'testing' }
ViennaSpecificationModificationEpiLog >> isSpecificationModificationEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaSpecificationModificationEpiLog >> isSyntacticClosureMember [

	^ true
]

{ #category : 'printing' }
ViennaSpecificationModificationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Edit'
]
