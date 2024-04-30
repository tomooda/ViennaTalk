Class {
	#name : 'ViennaInitializationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'state'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaInitializationEpiLog class >> after: aViennaEpiLog state: aDictionary [

	^ (self after: aViennaEpiLog)
		  state: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> defaultComment [

	^ 'Init'
]

{ #category : 'testing' }
ViennaInitializationEpiLog >> hasStateChange [

	^ true
]

{ #category : 'testing' }
ViennaInitializationEpiLog >> isInitializationEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaInitializationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Init'
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> state [

	^ state
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> state: aDictionary [

	state := aDictionary
]
