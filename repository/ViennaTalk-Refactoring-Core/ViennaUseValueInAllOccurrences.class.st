Class {
	#name : #ViennaUseValueInAllOccurrences,
	#superclass : #ViennaUseInAllOccurrences,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> execute [

	ast module allDescendantsDo: [ :node |
		((node includesParent: self definitionNode) not and: [
			 node sameAs: ast ]) ifTrue: [
			self
				replaceNode: node
				with: (ViennaLocalNameNode identifier: self identifier) ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> findDefinitionNode [

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first label = 'ValueDefinitions' ifTrue: [
				definitionBlock first do: [ :accessValueDef |
					accessValueDef second ifNotNil: [ :valueDef |
						((ast sameAs: valueDef third) and: [
							 valueDef first isViennaPatternIdentifierNode and: [
								 (ast includesParent: valueDef) not ] ]) ifTrue: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> identifier [
	^ (self definitionNode ifNotNil: #first) ifNotNil: #first
]
