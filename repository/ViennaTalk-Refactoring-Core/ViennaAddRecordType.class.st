Class {
	#name : 'ViennaAddRecordType',
	#superclass : 'ViennaAddToplevelDefinition',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddRecordType >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaTypeDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddRecordType >> name [
	^ 'Add record type ' , (newName ifNil: [ '' ])
]

{ #category : 'instance creation' }
ViennaAddRecordType >> newNameQuery [

	^ 'New record name'
]

{ #category : 'accessing' }
ViennaAddRecordType >> parser [

	^ ViennaVDMParser current accessTypeDefinition end
]

{ #category : 'accessing' }
ViennaAddRecordType >> sortingOrder [
	^ 0.01
]

{ #category : 'accessing' }
ViennaAddRecordType >> sourceWithNewName: aString [

	^ aString , '::'
]
