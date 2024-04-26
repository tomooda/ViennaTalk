Class {
	#name : #ViennaAddExplicitOperation,
	#superclass : #ViennaAddToplevelDefinition,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddExplicitOperation >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaOperationDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaAddExplicitOperation >> name [
	^ 'Add explicit operation ' , (newName ifNil: [ '' ])
]

{ #category : #accessing }
ViennaAddExplicitOperation >> newNameQuery [

	^ 'a new explicit operation name'
]

{ #category : #accessing }
ViennaAddExplicitOperation >> parser [

	^ ViennaVDMParser current accessOperationDefinition end
]

{ #category : #accessing }
ViennaAddExplicitOperation >> sortingOrder [
	^ 0.0
]

{ #category : #accessing }
ViennaAddExplicitOperation >> sourceWithNewName: aString [

	^ aString , ' : () ==> () ' , aString , '() == skip pre true post false'
]
