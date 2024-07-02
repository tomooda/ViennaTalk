Class {
	#name : 'ViennaAddTypesSection',
	#superclass : 'ViennaAddSection',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddTypesSection >> name [
	^ 'Add types section'
]

{ #category : 'accessing' }
ViennaAddTypesSection >> sortingOrder [
	^ 0.05
]

{ #category : 'accessing' }
ViennaAddTypesSection >> sourceWithNewName: aString [

	^ 'types'
]
