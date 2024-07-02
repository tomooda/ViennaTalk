Class {
	#name : 'ViennaAddExplicitFunction',
	#superclass : 'ViennaAddToplevelDefinition',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddExplicitFunction >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaFunctionDefinitionsNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddExplicitFunction >> name [

	^ 'Add explicit function ' , (newName ifNil: [ '' ])
]

{ #category : 'accessing' }
ViennaAddExplicitFunction >> newNameQuery [

	^ 'a new explicit function name'
]

{ #category : 'accessing' }
ViennaAddExplicitFunction >> parser [

	^ ViennaVDMParser current accessFunctionDefinition end
]

{ #category : 'accessing' }
ViennaAddExplicitFunction >> sortingOrder [
	^ 0.0
]

{ #category : 'accessing' }
ViennaAddExplicitFunction >> sourceWithNewName: aString [

	^ aString , ' : () -> ? ' , aString , '() == undefined pre true post false'
]
