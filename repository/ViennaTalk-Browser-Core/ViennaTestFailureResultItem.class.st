Class {
	#name : #ViennaTestFailureResultItem,
	#superclass : #ViennaTestResultItem,
	#category : #'ViennaTalk-Browser-Core-TestRunner'
}

{ #category : #accessing }
ViennaTestFailureResultItem class >> iconColor [
	^ Color yellow
]

{ #category : #testing }
ViennaTestFailureResultItem >> isFailure [
	^ true
]

{ #category : #accessing }
ViennaTestFailureResultItem >> sortingOrder [
	^ 1
]
