Class {
	#name : #ViennaAddRecordType,
	#superclass : #ViennaAddToplevelDefinition,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddRecordType >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast label = 'TypeDefinitions' ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaAddRecordType >> name [
	^ 'Add record type ' , (newName ifNil: [ '' ])
]

{ #category : #'instance creation' }
ViennaAddRecordType >> newNameQuery [

	^ 'New record name'
]

{ #category : #accessing }
ViennaAddRecordType >> parser [

	^ ViennaVDMParser new accessTypeDefinition end
]

{ #category : #accessing }
ViennaAddRecordType >> sortingOrder [
	^ 0.01
]

{ #category : #accessing }
ViennaAddRecordType >> sourceWithNewName: aString [

	^ aString , '::'
]
