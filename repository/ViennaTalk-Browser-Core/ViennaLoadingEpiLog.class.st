Class {
	#name : 'ViennaLoadingEpiLog',
	#superclass : 'ViennaModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaLoadingEpiLog >> basicPred [

	^ nil
]

{ #category : 'testing' }
ViennaLoadingEpiLog >> isLoadEpiLog [

	^ false
]

{ #category : 'printing' }
ViennaLoadingEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Load'
]
