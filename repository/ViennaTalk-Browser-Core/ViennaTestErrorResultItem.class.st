Class {
	#name : 'ViennaTestErrorResultItem',
	#superclass : 'ViennaTestResultItem',
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'accessing' }
ViennaTestErrorResultItem class >> iconColor [
	^ Color red
]

{ #category : 'testing' }
ViennaTestErrorResultItem >> isError [
	^ true
]

{ #category : 'accessing' }
ViennaTestErrorResultItem >> sortingOrder [
	^ 0
]
