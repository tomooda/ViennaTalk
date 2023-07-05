Class {
	#name : #ViennaInlineValue,
	#superclass : #ViennaInline,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineValue >> check [

	^ ast notNil and: [
		  ast isViennaLocalNameNode and: [
			  (ast resolveIdentifier: ast identifier) ifNotNil: [
				  :valueDefinition |
				  valueDefinition isViennaAccessValueDefinitionNode and: [
					  valueDefinition pattern isViennaPatternIdentifierNode ] ] ] ]
]

{ #category : #operations }
ViennaInlineValue >> execute [

	^ (ast resolveIdentifier: ast identifier) ifNotNil: [
		  :valueDefinition |
		  self
			  replaceNode: ast
			  with: valueDefinition expression copyFragment ]
]

{ #category : #accessing }
ViennaInlineValue >> sortingOrder [
	^ 2.14
]
