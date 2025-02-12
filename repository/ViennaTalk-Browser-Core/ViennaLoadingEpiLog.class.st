Class {
	#name : 'ViennaLoadingEpiLog',
	#superclass : 'ViennaModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaLoadingEpiLog class >> metadataName [

	^ 'Loading'
]

{ #category : 'accessing' }
ViennaLoadingEpiLog >> basicPred [

	^ nil
]

{ #category : 'testing' }
ViennaLoadingEpiLog >> isLoadEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaLoadingEpiLog >> isSemanticClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaLoadingEpiLog >> isSyntacticClosureMember [

	^ false
]

{ #category : 'printing' }
ViennaLoadingEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Load'
]
