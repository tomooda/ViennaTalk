Class {
	#name : #ViennaAddImplicitFunction,
	#superclass : #ViennaAddToplevelDefinition,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddImplicitFunction >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast label = 'FunctionDefinitions' ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaAddImplicitFunction >> name [
	^ 'Add implicit function ' , (newName ifNil: [ '' ])
]

{ #category : #'instance creation' }
ViennaAddImplicitFunction >> newNameQuery [

	^ 'a new implicit function name'
]

{ #category : #accessing }
ViennaAddImplicitFunction >> parser [

	^ ViennaVDMParser new accessFunctionDefinition end
]

{ #category : #accessing }
ViennaAddImplicitFunction >> sortingOrder [
	^ 0.01
]

{ #category : #accessing }
ViennaAddImplicitFunction >> sourceWithNewName: aString [

	^ aString , '() res:? post true'
]
