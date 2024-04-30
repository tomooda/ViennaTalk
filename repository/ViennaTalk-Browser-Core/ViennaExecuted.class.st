Class {
	#name : 'ViennaExecuted',
	#superclass : 'Announcement',
	#instVars : [
		'statement'
	],
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'instance creation' }
ViennaExecuted class >> statement: aString [

	^ self new
		  statement: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaExecuted >> statement [

	^ statement
]

{ #category : 'accessing' }
ViennaExecuted >> statement: aString [

	statement := aString
]
