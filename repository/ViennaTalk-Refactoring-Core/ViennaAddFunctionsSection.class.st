Class {
	#name : #ViennaAddFunctionsSection,
	#superclass : #ViennaAddSection,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddFunctionsSection >> name [
	^ 'Add functions section'
]

{ #category : #accessing }
ViennaAddFunctionsSection >> sortingOrder [
	^ 0.07
]

{ #category : #accessing }
ViennaAddFunctionsSection >> sourceWithNewName: aString [

	^ 'functions'
]
