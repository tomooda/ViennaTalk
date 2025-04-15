Class {
	#name : 'ViennaUnitTestSuccessResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestSuccessResultItem class >> icon [

	^ self successIcon
]

{ #category : 'initialization' }
ViennaUnitTestSuccessResultItem >> initialize [

	super initialize.
	result := #success
]
