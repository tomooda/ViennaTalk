Class {
	#name : #ViennaErrorListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaErrorListNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray inject: '' into: [ :string :node |
		  string , ' ' , (aViennaAbstractFormatter format: node) ]
]

{ #category : #'as yet unclassified' }
ViennaErrorListNode >> isViennaErrorListNode [

	^ true
]

{ #category : #accessing }
ViennaErrorListNode >> label [

	^ 'ErrorList'
]
