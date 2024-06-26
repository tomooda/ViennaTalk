Class {
	#name : 'ViennaAddImplicitOperation',
	#superclass : 'ViennaAddToplevelDefinition',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddImplicitOperation >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaOperationDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddImplicitOperation >> name [
	^ 'Add implicit operation ' , (newName ifNil: [ '' ])
]

{ #category : 'instance creation' }
ViennaAddImplicitOperation >> newNameQuery [

	^ 'a new implicit operation name'
]

{ #category : 'accessing' }
ViennaAddImplicitOperation >> parser [

	^ ViennaVDMParser current accessOperationDefinition end
]

{ #category : 'accessing' }
ViennaAddImplicitOperation >> sortingOrder [
	^ 0.01
]

{ #category : 'accessing' }
ViennaAddImplicitOperation >> sourceWithNewName: aString [

	^ aString , ' () post true'
]
