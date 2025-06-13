Class {
	#name : 'ViennaUnitTestErrorResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem class >> icon [

	^ self errorIcon
]

{ #category : 'initialization' }
ViennaUnitTestErrorResultItem >> initialize [

	super initialize.
	result := #error
]
