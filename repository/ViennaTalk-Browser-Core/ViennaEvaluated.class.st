Class {
	#name : #ViennaEvaluated,
	#superclass : #Announcement,
	#instVars : [
		'expression'
	],
	#category : #'ViennaTalk-Browser-Core-Spec2'
}

{ #category : #'instance creation' }
ViennaEvaluated class >> expression: aString [

	^ self new
		  expression: aString;
		  yourself
]

{ #category : #accessing }
ViennaEvaluated >> expression [

	^ expression
]

{ #category : #accessing }
ViennaEvaluated >> expression: aString [

	expression := aString
]
