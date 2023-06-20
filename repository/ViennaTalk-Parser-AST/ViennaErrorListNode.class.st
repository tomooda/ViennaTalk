Class {
	#name : #ViennaErrorListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaErrorListNode >> boundIdentifiersDo: aBlock [

	self do: [ :error | error boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaErrorListNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray inject: '' into: [ :string :node |
		  string , ' ' , (aViennaAbstractFormatter format: node) ]
]

{ #category : #testing }
ViennaErrorListNode >> isViennaErrorListNode [

	^ true
]

{ #category : #accessing }
ViennaErrorListNode >> label [

	^ 'ErrorList'
]
