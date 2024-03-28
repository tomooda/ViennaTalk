Class {
	#name : #ViennaExecutionEpiLog,
	#superclass : #ViennaEpiLog,
	#instVars : [
		'statement',
		'state'
	],
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #'instance creaiton' }
ViennaExecutionEpiLog class >> after: aViennaEpiLog statement: aString [

	^ (self after: aViennaEpiLog)
		  statement: aString;
		  yourself
]

{ #category : #'instance creaiton' }
ViennaExecutionEpiLog class >> after: aViennaEpiLog statement: aString state: aDictionary [

	^ (self after: aViennaEpiLog)
		  statement: aString;
		  state: aDictionary;
		  yourself
]

{ #category : #testing }
ViennaExecutionEpiLog >> hasStateChange [

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : #testing }
ViennaExecutionEpiLog >> isExecutionEpiLog [

	^ true
]

{ #category : #printing }
ViennaExecutionEpiLog >> printOn: aStream [

	aStream
		nextPutAll: 'Exec ';
		nextPutAll: statement
]

{ #category : #accessing }
ViennaExecutionEpiLog >> state [

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : #accessing }
ViennaExecutionEpiLog >> state: aDictionary [

	self state ~= aDictionary ifTrue: [ state := aDictionary ]
]

{ #category : #accessing }
ViennaExecutionEpiLog >> statement [

	^ statement
]

{ #category : #accessing }
ViennaExecutionEpiLog >> statement: aString [

	statement := aString
]
