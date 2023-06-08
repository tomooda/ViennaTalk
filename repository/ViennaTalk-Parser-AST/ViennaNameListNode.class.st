Class {
	#name : #ViennaNameListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNameListNode >> formatWith: aViennaAbstractFormatter [

	| names |
	names := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: ', ' withAll: names
]

{ #category : #accessing }
ViennaNameListNode >> label [

	^ 'NameList'
]
