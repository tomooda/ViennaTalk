Class {
	#name : #ViennaTestFailureResultItem,
	#superclass : #ViennaTestResultItem,
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #accessing }
ViennaTestFailureResultItem class >> iconColor [
	^ Color yellow
]

{ #category : #testing }
ViennaTestFailureResultItem >> isFailure [
	^ true
]
