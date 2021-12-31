Class {
	#name : #ViennaAddModule,
	#superclass : #ViennaAdd,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddModule >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast label = 'Document' ifTrue: [ ^ ast ].
	ast label = 'Module' ifTrue: [ ^ ast document ].
	^ nil
]

{ #category : #accessing }
ViennaAddModule >> findNewName [

	^ super findNewName ifNotNil: [ :name | 
		  (ast document moduleNamed: name) ifNil: [ name ] ifNotNil: [ 
			  UIManager default alert: name , ' is already defined.'.
			  nil ] ]
]

{ #category : #accessing }
ViennaAddModule >> name [
	^ 'Add new module ' , (newName ifNil: [ '' ])
]

{ #category : #accessing }
ViennaAddModule >> newNameQuery [

	^ 'new module name'
]

{ #category : #accessing }
ViennaAddModule >> parser [

	^ ViennaVDMParser new module end
]

{ #category : #accessing }
ViennaAddModule >> sortingOrder [
	^ 0.0
]

{ #category : #accessing }
ViennaAddModule >> sourceWithNewName: aString [

	^ 'module ' , aString , ' exports all definitions end ' , aString
]
