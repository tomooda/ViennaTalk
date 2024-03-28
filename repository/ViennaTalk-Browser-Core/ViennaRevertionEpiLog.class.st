Class {
	#name : #ViennaRevertionEpiLog,
	#superclass : #ViennaEpiLog,
	#instVars : [
		'destination'
	],
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #'instance creation' }
ViennaRevertionEpiLog class >> after: aViennaEpiLog destination: anotherViennaEpiLog [

	^ (self after: aViennaEpiLog)
		  destination: anotherViennaEpiLog;
		  yourself
]

{ #category : #accessing }
ViennaRevertionEpiLog >> destination [

	^ destination
]

{ #category : #accessing }
ViennaRevertionEpiLog >> destination: aViennaEpiLog [

	destination := aViennaEpiLog
]

{ #category : #testing }
ViennaRevertionEpiLog >> hasChangeAtModule: aString [

	^ (destination specification moduleNamed: aString)
	  ~= (prev specification moduleNamed: aString)
]

{ #category : #testing }
ViennaRevertionEpiLog >> hasSpecificationChange [

	^ destination specification ~= prev specification
]

{ #category : #testing }
ViennaRevertionEpiLog >> hasStateChange [

	^ destination state ~= prev state
]

{ #category : #testing }
ViennaRevertionEpiLog >> isRevertionEpiLog [

	^ true
]

{ #category : #printing }
ViennaRevertionEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Revert to "'.
	destination printOn: aStream.
	aStream nextPut: $"
]

{ #category : #accessing }
ViennaRevertionEpiLog >> revertDestination [

	^ destination
]

{ #category : #accessing }
ViennaRevertionEpiLog >> specification [

	^ destination specification
]

{ #category : #accessing }
ViennaRevertionEpiLog >> state [

	^ destination state
]
