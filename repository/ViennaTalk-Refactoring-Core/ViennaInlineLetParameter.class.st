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
	self definitionNode first asArray
		do: [ :localDef | 
			(localDef first label = 'ValueDefinition'
				and: [ localDef first first == ast ])
				ifTrue: [ expr := localDef first third.
					localDef parent remove: localDef ] ].
	self definitionNode first asArray
		do: [ :localDef | 
			self
				freeOccurrencesOf: ast name
				in: localDef
				do: [ :localName | self replaceNode: localName with: expr copyFragment ] ].
	self
		freeOccurrencesOf: ast name
		in: self definitionNode second
		do: [ :localName | self replaceNode: localName with: expr copyFragment ].
	^ self definitionNode
]

{ #category : #accessing }
ViennaInlineLetParameter >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast label = 'PatternIdentifier'
		ifFalse: [ ^ nil ].
	ast parent
		ifNotNil: [ :valueDefinition | 
			valueDefinition label = 'ValueDefinition'
				ifFalse: [ ^ nil ].
			valueDefinition parent
				ifNotNil: [ :localDefinition | 
					localDefinition label = 'LocalDefinition'
						ifFalse: [ ^ nil ].
					localDefinition parent
						ifNotNil: [ :localDefinitionList | 
							localDefinitionList label = 'LocalDefinitionList'
								ifFalse: [ ^ nil ].
							localDefinitionList parent
								ifNotNil: [ :let | 
									(#('LetExpression' 'LetStatement') includes: let label)
										ifFalse: [ ^ nil ].
									^ let ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaInlineLetParameter >> sortingOrder [
	^ 2.18
]
