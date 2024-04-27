Class {
	#name : #ViennaErrorListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaErrorListNode >> boundIdentifiersDo: aBlock [

	self do: [ :error | error boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaErrorListNode >> formatWith: aViennaAbstractFormatter [

	^ self
		  inject: aViennaAbstractFormatter empty
		  into: [ :string :node |
			  string , aViennaAbstractFormatter space
			  , (aViennaAbstractFormatter format: node) ]
]

{ #category : #private }
ViennaErrorListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :error | error freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaErrorListNode >> isViennaErrorListNode [

	^ true
]

{ #category : #accessing }
ViennaErrorListNode >> label [

	^ 'ErrorList'
]

{ #category : #typechecking }
ViennaErrorListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
