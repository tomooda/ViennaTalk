Class {
	#name : #ViennaInlineType,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineType >> check [

	ast ifNil: [ ^ false ].
	ast isTypeNode ifFalse: [ ^ false ].
	ast label isViennaNameNode ifTrue: [ ast := ast parent ].
	^ ast isViennaTypeNameNode and: [
		  ast name isViennaLocalNameNode and: [
			  (ast definitionOfLocalName: ast name identifier) ifNotNil: [
				  :node |
				  node label = 'TypeDefinition'
					  ifTrue: [ node third isNil ]
					  ifFalse: [ false ] ] ] ]
]

{ #category : #operations }
ViennaInlineType >> execute [
	^ self
		replaceNode: ast
		with: (ast definitionOfLocalName: ast first first) second copyFragment
]

{ #category : #accessing }
ViennaInlineType >> sortingOrder [
	^ 2.11
]
