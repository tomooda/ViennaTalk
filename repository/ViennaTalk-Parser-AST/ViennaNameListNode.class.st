Class {
	#name : #ViennaNameListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaNameListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaNameListNode >> formatWith: aViennaAbstractFormatter [

	| names |
	names := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: ', ' withAll: names
]

{ #category : #private }
ViennaNameListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :name | name freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaNameListNode >> includesIdentifier: aString [

	^ self anySatisfy: [ :name | name identifier = aString ]
]

{ #category : #testing }
ViennaNameListNode >> isViennaNameListNode [

	^ true
]

{ #category : #accessing }
ViennaNameListNode >> label [

	^ 'NameList'
]

{ #category : #typechecking }
ViennaNameListNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :name | type + name typecheck ]
]

{ #category : #typechecking }
ViennaNameListNode >> maximalType: aViennaType [

	self do: [ :name | name maximalType: aViennaType ].
	super maximalType: aViennaType
]

{ #category : #removing }
ViennaNameListNode >> removeIdentifier: aString [

	(self includesIdentifier: aString) ifTrue: [
		self removeAll: (self select: [ :name | name identifier = aString ]) ]
]
