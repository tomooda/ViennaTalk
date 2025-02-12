Class {
	#name : 'ViennaVanillaEpiLog',
	#superclass : 'ViennaModificationEpiLog',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaVanillaEpiLog class >> metadataName [

	^ 'Vanilla'
]

{ #category : 'accessing' }
ViennaVanillaEpiLog >> basicPred [

	^ nil
]

{ #category : 'initialization' }
ViennaVanillaEpiLog >> initialize [

	super initialize.
	specification := ViennaModularDocumentNode new.
	state := Dictionary new
]

{ #category : 'testing' }
ViennaVanillaEpiLog >> isVanillaEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaVanillaEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Vanilla'
]
