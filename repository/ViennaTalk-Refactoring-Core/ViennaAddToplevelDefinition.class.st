Class {
	#name : #ViennaAddToplevelDefinition,
	#superclass : #ViennaAdd,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaAddToplevelDefinition class >> isAbstract [

	^ self == ViennaAddToplevelDefinition
]

{ #category : #accessing }
ViennaAddToplevelDefinition >> findNewName [

	^ super findNewName ifNotNil: [ :name |
		  (ast module lookupIdentifier: name) ifNil: [ name ] ifNotNil: [
			  UIManager default alert: name , ' is already defined.'.
			  nil ] ]
]
