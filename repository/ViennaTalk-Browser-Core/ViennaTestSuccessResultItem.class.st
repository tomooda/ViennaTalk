Class {
	#name : #ViennaTestSuccessResultItem,
	#superclass : #ViennaTestResultItem,
	#category : #'ViennaTalk-Browser-Core-TestRunner'
}

{ #category : #accessing }
ViennaTestSuccessResultItem class >> iconColor [
	^ Color green
]

{ #category : #testing }
ViennaTestSuccessResultItem >> isSuccess [
	^ true
]

{ #category : #accessing }
ViennaTestSuccessResultItem >> sortingOrder [
	^ 2
]
