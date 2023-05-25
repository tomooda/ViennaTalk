Class {
	#name : #ViennaSplitLetParameter,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaSplitLetParameter >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaSplitLetParameter >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaSplitLetParameter >> definitionNode: anObject [
	definitionNode := anObject
]

{ #category : #operations }
ViennaSplitLetParameter >> execute [

	| localDefinition dummyNode |
	localDefinition := ast parent parent.
	localDefinition parent remove: localDefinition.
	^ (self definitionNode parent isViennaLetExpressionNode or: [
		   self definitionNode parent label = 'LetStatement' ])
		  ifTrue: [ self definitionNode parent first add: localDefinition ]
		  ifFalse: [
			  self
				  replaceNode: self definitionNode
				  with: (dummyNode := ViennaNode label: 'DUMMY').
			  self replaceNode: dummyNode with: (ViennaNode
					   label: self definitionNode label
					   with:
					   (ViennaNode label: 'LocalDefinitionList' with: localDefinition)
					   with: self definitionNode) ]
]

{ #category : #accessing }
ViennaSplitLetParameter >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast label = 'PatternIdentifier' ifFalse: [ ^ nil ].
	ast parent ifNotNil: [ :valueDefinition |
		valueDefinition label = 'ValueDefinition' ifFalse: [ ^ nil ].
		valueDefinition parent ifNotNil: [ :localDefinition |
			localDefinition label = 'LocalDefinition' ifFalse: [ ^ nil ].
			localDefinition parent ifNotNil: [ :localDefinitionList |
				localDefinitionList label = 'LocalDefinitionList' ifFalse: [
					^ nil ].
				localDefinitionList size > 1 ifFalse: [ ^ nil ].
				localDefinitionList parent ifNotNil: [ :let |
					let isViennaLetNode ifFalse: [ ^ nil ].
					^ let ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaSplitLetParameter >> name [
	^ 'Split let ', ast name
]

{ #category : #accessing }
ViennaSplitLetParameter >> sortingOrder [
	^ 3.63
]
