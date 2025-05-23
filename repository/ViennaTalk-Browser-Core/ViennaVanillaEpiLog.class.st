Class {
	#name : 'ViennaVanillaEpiLog',
	#superclass : 'ViennaAbstractModificationEpiLog',
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
ViennaVanillaEpiLog >> isExecutionClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaVanillaEpiLog >> isRemovable [

	^ false
]

{ #category : 'testing' }
ViennaVanillaEpiLog >> isSemanticClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaVanillaEpiLog >> isSyntacticClosureMember [

	^ false
]

{ #category : 'testing' }
ViennaVanillaEpiLog >> isVanillaEpiLog [

	^ true
]

{ #category : 'accessing' }
ViennaVanillaEpiLog >> prev [

	^ nil
]

{ #category : 'accessing' }
ViennaVanillaEpiLog >> prev: aViennaEpiLog [

	
]

{ #category : 'printing' }
ViennaVanillaEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Vanilla'
]
