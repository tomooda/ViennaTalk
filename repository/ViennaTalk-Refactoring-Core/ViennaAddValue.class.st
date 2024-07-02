Class {
	#name : 'ViennaAddValue',
	#superclass : 'ViennaAddToplevelDefinition',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddValue >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaValueDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddValue >> name [
	^ 'Add value ' , (newName ifNil: [ '' ])
]

{ #category : 'accessing' }
ViennaAddValue >> newNameQuery [

	^ 'New value name'
]

{ #category : 'accessing' }
ViennaAddValue >> parser [

	^ ViennaVDMParser current accessValueDefinition end
]

{ #category : 'accessing' }
ViennaAddValue >> sortingOrder [
	^ 0.0
]

{ #category : 'accessing' }
ViennaAddValue >> sourceWithNewName: aString [

	^ aString , ': ? = undefined'
]
