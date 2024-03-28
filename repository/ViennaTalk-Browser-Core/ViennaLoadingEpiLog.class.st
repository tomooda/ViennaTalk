Class {
	#name : #ViennaLoadingEpiLog,
	#superclass : #ViennaModificationEpiLog,
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #testing }
ViennaLoadingEpiLog >> isLoadEpiLog [

	^ false
]

{ #category : #printing }
ViennaLoadingEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Load'
]
