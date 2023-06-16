Class {
	#name : #ViennaRenameValue,
	#superclass : #ViennaRenameToplevel,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameValue >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaRenameValue >> construct [
	^ 'constant value'
]

{ #category : #operations }
ViennaRenameValue >> executeOnDefinition [
	self definitionNode
		ifNotNil: [ :valueDefinition | 
			self
				patternIdentifiersWith: self oldName
				in: valueDefinition first
				do: [ :patternIdentifier | patternIdentifier at: 1 put: self newName ] ]
]

{ #category : #accessing }
ViennaRenameValue >> findDefinitionNode [

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaValueDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessValueDef |
					accessValueDef second ifNotNil: [ :valueDef |
						self
							patternIdentifiersWith: self oldName
							in: valueDef first
							do: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameValue >> findOldName [

	(ast isViennaValueDefinitionNode and: [
		 ast pattern isViennaPatternIdentifierNode ]) ifTrue: [
		^ ast pattern identifier ].
	ast isViennaPatternIdentifierNode ifTrue: [ ^ ast identifier ].
	ast isViennaLocalNameNode ifTrue: [ ^ ast identifier ].
	^ nil
]

{ #category : #accessing }
ViennaRenameValue >> sortingOrder [
	^ 1.4
]
