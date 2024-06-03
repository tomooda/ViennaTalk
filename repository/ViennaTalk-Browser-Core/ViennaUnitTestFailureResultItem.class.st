Class {
	#name : 'ViennaUnitTestFailureResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem class >> icon [

	^ self failureIcon
]

{ #category : 'testing' }
ViennaUnitTestFailureResultItem >> isFailure [
	^ true
]

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem >> sortingOrder [
	^ 1
]
