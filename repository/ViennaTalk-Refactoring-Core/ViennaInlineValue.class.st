Class {
	#name : #ViennaInlineValue,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineValue >> check [
	^ ast notNil and: [ ast isLocalValueNameNode ]
]

{ #category : #operations }
ViennaInlineValue >> execute [

	^ ((ast definitionOfLocalName: ast identifier)
		   detectParent: #isViennaValueDefinitionNode
		   ifNone: [ nil ]) ifNotNil: [ :valueDefinition |
		  self
			  replaceNode: ast
			  with: valueDefinition expression copyFragment ]
]

{ #category : #accessing }
ViennaInlineValue >> sortingOrder [
	^ 2.14
]
