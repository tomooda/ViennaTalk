Class {
	#name : 'ViennaAddOperationsSection',
	#superclass : 'ViennaAddSection',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddOperationsSection >> name [
	^ 'Add operations section'
]

{ #category : 'accessing' }
ViennaAddOperationsSection >> sortingOrder [
	^ 0.09
]

{ #category : 'accessing' }
ViennaAddOperationsSection >> sourceWithNewName: aString [

	^ 'operations'
]
