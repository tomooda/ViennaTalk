Class {
	#name : #ViennaNameListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaNameListNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaNameListNode >> formatWith: aViennaAbstractFormatter [

	| names |
	names := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: ', ' withAll: names
]

{ #category : #testing }
ViennaNameListNode >> isViennaNameListNode [

	^ true
]

{ #category : #accessing }
ViennaNameListNode >> label [

	^ 'NameList'
]
