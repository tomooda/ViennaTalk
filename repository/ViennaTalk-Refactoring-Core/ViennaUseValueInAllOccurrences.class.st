Class {
	#name : #ViennaUseValueInAllOccurrences,
	#superclass : #ViennaUseInAllOccurrences,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> execute [

	ast module allDescendantsDo: [ :node |
		((node includesParent: self definitionNode) not and: [ node = ast ])
			ifTrue: [
				self
					replaceNode: node
					with: (ViennaLocalNameNode identifier: self identifier) ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> findDefinitionNode [

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaValueDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessValueDef |
					accessValueDef second ifNotNil: [ :valueDef |
						(ast = valueDef third and: [
							 valueDef first isViennaPatternIdentifierNode and: [
								 (ast includesParent: valueDef) not ] ]) ifTrue: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> identifier [
	^ (self definitionNode ifNotNil: #first) ifNotNil: #first
]
