Class {
	#name : #ViennaInlineLetParameter,
	#superclass : #ViennaInline,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineLetParameter >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaInlineLetParameter >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaInlineLetParameter >> definitionNode: anObject [
	definitionNode := anObject
]

{ #category : #operations }
ViennaInlineLetParameter >> execute [

	| expr |
	self definitionNode localDefinitionList asArray do: [ :localDef |
		(localDef isViennaValueDefinitionNode and: [
			 localDef pattern == ast ]) ifTrue: [
			expr := localDef expression.
			localDef parent remove: localDef ] ].
	self definitionNode localDefinitionList asArray do: [ :localDef |
		localDef freeIdentifiersExcept: Set new do: [ :identifier :node |
			identifier = self ast identifier ifTrue: [
				self replaceNode: node with: expr copyFragment ] ] ].
	self definitionNode body
		freeIdentifiersExcept: Set new
		do: [ :identifier :node |
			identifier = self ast identifier ifTrue: [
				self replaceNode: node with: expr copyFragment ] ].
	^ self definitionNode
]

{ #category : #accessing }
ViennaInlineLetParameter >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaPatternIdentifierNode ifFalse: [ ^ nil ].
	ast parent ifNotNil: [ :valueDefinition |
		valueDefinition isViennaValueDefinitionNode ifFalse: [ ^ nil ].
		valueDefinition parent ifNotNil: [ :localDefinitionList |
			localDefinitionList isViennaLocalDefinitionListNode ifFalse: [
				^ nil ].
			localDefinitionList parent ifNotNil: [ :let |
				let isViennaLetNode ifFalse: [ ^ nil ].
				^ let ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineLetParameter >> sortingOrder [
	^ 2.18
]
