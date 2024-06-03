Class {
	#name : 'ViennaUnitTestErrorResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem class >> icon [

	^ self errorIcon
]

{ #category : 'testing' }
ViennaUnitTestErrorResultItem >> isError [
	^ true
]

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem >> sortingOrder [
	^ 0
]
