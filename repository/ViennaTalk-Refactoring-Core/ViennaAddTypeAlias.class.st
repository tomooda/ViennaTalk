Class {
	#name : 'ViennaAddTypeAlias',
	#superclass : 'ViennaAddToplevelDefinition',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddTypeAlias >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaTypeDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddTypeAlias >> name [
	^ 'Add type alias ' , (newName ifNil: [ '' ])
]

{ #category : 'accessing' }
ViennaAddTypeAlias >> newNameQuery [

	^ 'New type name'
]

{ #category : 'accessing' }
ViennaAddTypeAlias >> parser [

	^ ViennaVDMParser current accessTypeDefinition end
]

{ #category : 'accessing' }
ViennaAddTypeAlias >> sortingOrder [
	^ 0.0
]

{ #category : 'accessing' }
ViennaAddTypeAlias >> sourceWithNewName: aString [

	^ aString , ' = ?'
]
