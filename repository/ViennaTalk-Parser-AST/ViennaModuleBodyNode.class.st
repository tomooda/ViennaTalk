Class {
	#name : #ViennaModuleBodyNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaModuleBodyNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaModuleBodyNode >> formatWith: aViennaAbstractFormatter [

	| definitionBlocks |
	definitionBlocks := aViennaAbstractFormatter formatAll: self.
	^ 'definitions' , String cr
	  ,
	  (aViennaAbstractFormatter join: String cr withAll: definitionBlocks)
]

{ #category : #testing }
ViennaModuleBodyNode >> isViennaModuleBodyNode [

	^ true
]

{ #category : #accessing }
ViennaModuleBodyNode >> label [

	^ 'ModuleBody'
]
