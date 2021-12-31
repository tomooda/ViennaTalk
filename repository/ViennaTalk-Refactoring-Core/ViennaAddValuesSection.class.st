Class {
	#name : #ViennaAddValuesSection,
	#superclass : #ViennaAddSection,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddValuesSection >> name [
	^ 'Add values section'
]

{ #category : #accessing }
ViennaAddValuesSection >> sortingOrder [
	^ 0.06
]

{ #category : #accessing }
ViennaAddValuesSection >> sourceWithNewName: aString [

	^ 'values'
]
