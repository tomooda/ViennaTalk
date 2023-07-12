Class {
	#name : #ViennaExtractType,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractType >> check [

	ast isViennaTypeNode ifFalse: [ ^ false ].
	ast isViennaNameNode ifTrue: [ ast := ast parent ].
	^ true
]

{ #category : #operations }
ViennaExtractType >> execute [

	| module typeDefinition |
	self newName ifNil: [ ^ nil ].
	module := ast module.
	self replaceNode: ast with: (ViennaTypeNameNode name:
			 (ViennaLocalNameNode identifier: self newName)).
	typeDefinition := ViennaTypeSynonymNode
		                  identifier: self newName
		                  type: ast
		                  inv: nil.
	self addTypeDefinition: typeDefinition in: module.
	^ typeDefinition
]

{ #category : #accessing }
ViennaExtractType >> findNewName [
	(UIManager default
		request: 'type name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractType >> name [

	^ 'Extract type '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from ' asText
	  , (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractType >> sortingOrder [
	^ 2.51
]
