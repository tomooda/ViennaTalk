Class {
	#name : #ViennaAddStateDefinition,
	#superclass : #ViennaAddToplevelDefinition,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddStateDefinition >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaModuleNode ifTrue: [
		ast moduleBody do: [ :def |
			def isViennaStateDefinitionNode ifTrue: [ ^ nil ] ].
		^ ast third ].
	^ nil
]

{ #category : #accessing }
ViennaAddStateDefinition >> name [
	^ 'Add state section ' , (newName ifNil: [ '' ])
]

{ #category : #accessing }
ViennaAddStateDefinition >> newNameQuery [

	^ 'a state constructor name'
]

{ #category : #accessing }
ViennaAddStateDefinition >> parser [

	^ ViennaVDMParser new definitionBlock end
]

{ #category : #accessing }
ViennaAddStateDefinition >> sortingOrder [
	^ 0.08
]

{ #category : #accessing }
ViennaAddStateDefinition >> sourceWithNewName: aString [

	^ 'state ' , aString , ' of init s == s = mk_' , aString , '() end'
]
