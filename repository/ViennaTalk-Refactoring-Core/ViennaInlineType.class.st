Class {
	#name : #ViennaInlineType,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineType >> check [

	ast ifNil: [ ^ false ].
	ast isViennaTypeNode ifFalse: [ ^ false ].
	ast isViennaNameNode ifTrue: [ ast := ast parent ].
	^ ast isViennaTypeNameNode and: [
		  ast name isViennaLocalNameNode and: [
			  (ast resolveIdentifier: ast name identifier) ifNotNil: [ :node |
				  node typeDefinition isViennaTypeSynonymNode
					  ifTrue: [ node inv isNil ]
					  ifFalse: [ false ] ] ] ]
]

{ #category : #operations }
ViennaInlineType >> execute [

	^ self
		  replaceNode: ast
		  with: (ast resolveIdentifier: ast identifier) typeDefinition type
				  copyFragment
]

{ #category : #accessing }
ViennaInlineType >> sortingOrder [
	^ 2.11
]
