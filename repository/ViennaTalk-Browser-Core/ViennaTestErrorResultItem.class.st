Class {
	#name : #ViennaTestErrorResultItem,
	#superclass : #ViennaTestResultItem,
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #accessing }
ViennaTestErrorResultItem class >> iconColor [
	^ Color red
]

{ #category : #testing }
ViennaTestErrorResultItem >> isError [
	^ true
]
