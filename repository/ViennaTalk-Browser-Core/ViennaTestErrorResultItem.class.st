Class {
	#name : #ViennaTestErrorResultItem,
	#superclass : #ViennaTestResultItem,
	#category : #'ViennaTalk-Browser-Core-TestRunner'
}

{ #category : #accessing }
ViennaTestErrorResultItem class >> iconColor [
	^ Color red
]

{ #category : #testing }
ViennaTestErrorResultItem >> isError [
	^ true
]

{ #category : #accessing }
ViennaTestErrorResultItem >> sortingOrder [
	^ 0
]
