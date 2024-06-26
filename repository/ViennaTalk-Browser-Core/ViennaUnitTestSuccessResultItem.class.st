Class {
	#name : 'ViennaUnitTestSuccessResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'accessing' }
ViennaUnitTestSuccessResultItem class >> icon [

	^ self successIcon
]

{ #category : 'accessing' }
ViennaUnitTestSuccessResultItem >> color [

	^ self class successIconColor
]

{ #category : 'testing' }
ViennaUnitTestSuccessResultItem >> isSuccess [
	^ true
]

{ #category : 'accessing' }
ViennaUnitTestSuccessResultItem >> sortingOrder [
	^ 2
]
