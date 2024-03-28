Class {
	#name : #ViennaVanillaEpiLog,
	#superclass : #ViennaModificationEpiLog,
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #initialization }
ViennaVanillaEpiLog >> initialize [

	super initialize.
	specification := ViennaModularDocumentNode new.
	state := Dictionary new
]

{ #category : #testing }
ViennaVanillaEpiLog >> isVanillaEpiLog [

	^ true
]

{ #category : #printing }
ViennaVanillaEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Vanilla'
]
