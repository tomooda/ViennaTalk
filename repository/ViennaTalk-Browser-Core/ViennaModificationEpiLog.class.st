Class {
	#name : #ViennaModificationEpiLog,
	#superclass : #ViennaEpiLog,
	#instVars : [
		'specification',
		'state'
	],
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #'instance creation' }
ViennaModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode [

	^ (self after: aViennaEpiLog)
		  specification: aViennaModularDocumentNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaModificationEpiLog class >> after: aViennaEpiLog specification: aViennaModularDocumentNode state: aDictionary [

	^ (self after: aViennaEpiLog)
		  specification: aViennaModularDocumentNode;
		  state: aDictionary;
		  yourself
]

{ #category : #testing }
ViennaModificationEpiLog >> hasChangeAtModule: aString [

	^ (specification moduleNamed: aString)
	  ~= (prev specification moduleNamed: aString)
]

{ #category : #testing }
ViennaModificationEpiLog >> hasSpecificationChange [

	^ prev isNil or: [ prev specification ~= specification ]
]

{ #category : #testing }
ViennaModificationEpiLog >> hasStateChange [

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : #testing }
ViennaModificationEpiLog >> isModificationEpiLog [

	^ true
]

{ #category : #printing }
ViennaModificationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Edit'
]

{ #category : #accessing }
ViennaModificationEpiLog >> specification [

	^ specification
]

{ #category : #accessing }
ViennaModificationEpiLog >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode
]

{ #category : #accessing }
ViennaModificationEpiLog >> state [

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : #accessing }
ViennaModificationEpiLog >> state: aDictionary [

	self state ~= aDictionary ifTrue: [ state := aDictionary ]
]
