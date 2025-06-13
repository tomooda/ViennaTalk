Class {
	#name : 'ViennaUnitTestFailureResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem class >> icon [

	^ self failureIcon
]

{ #category : 'initialization' }
ViennaUnitTestFailureResultItem >> initialize [

	super initialize.
	result := #failure
]
