Class {
	#name : #ViennaUseTypeSynonym,
	#superclass : #ViennaUse,
	#instVars : [
		'typeSynonyms',
		'typeSynonymIndex'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseTypeSynonym >> check [

	^ self typeSynonyms notEmpty
]

{ #category : #operations }
ViennaUseTypeSynonym >> execute [

	^ self replaceNode: ast with: (ViennaTypeNameNode name:
			   (ViennaLocalNameNode identifier: self definitionNode identifier))
]

{ #category : #accessing }
ViennaUseTypeSynonym >> findDefinitionNode [

	^ self typeSynonyms
		  ifNotEmpty: [ :synonyms |
		  self typeSynonymIndex ifNotNil: [ :i | synonyms at: i ] ]
		  ifEmpty: [ nil ]
]

{ #category : #accessing }
ViennaUseTypeSynonym >> findTypeSynonymIndex [

	^ UIManager default
		  chooseFrom: (self typeSynonyms collect: #identifier)
		  values: (1 to: self typeSynonyms size)
		  lines: #(  )
		  message: 'Select a type synonym to use'
		  title: 'Use type synonym'
]

{ #category : #accessing }
ViennaUseTypeSynonym >> findTypeSynonyms [

	ast ifNil: [ ^ Array new ].
	ast isViennaTypeNode ifFalse: [ ^ Array new ].
	^ Array streamContents: [ :stream |
		  self typeSynonymsDo: [ :synonym |
			  (synonym type ~~ ast and: [
				   synonym inv isNil and: [ synonym type = ast ] ]) ifTrue: [
				  stream nextPut: synonym ] ] ]
]

{ #category : #accessing }
ViennaUseTypeSynonym >> name [

	^ 'Use type synonym for '
	  , (self shortDescription: self ast source) asText allBold
]

{ #category : #accessing }
ViennaUseTypeSynonym >> typeSynonymIndex [

	^ typeSynonymIndex ifNil: [
		  typeSynonymIndex := self findTypeSynonymIndex ]
]

{ #category : #accessing }
ViennaUseTypeSynonym >> typeSynonymIndex: anInteger [

	typeSynonymIndex := anInteger
]

{ #category : #accessing }
ViennaUseTypeSynonym >> typeSynonyms [

	^ typeSynonyms ifNil: [ typeSynonyms := self findTypeSynonyms ]
]

{ #category : #enumerating }
ViennaUseTypeSynonym >> typeSynonymsDo: aBlock [

	self ast module sectionsDo: [ :section |
		section isViennaTypeDefinitionsNode ifTrue: [
			section do: [ :definition |
				definition type ifNotNil: [ aBlock value: definition ] ] ] ]
]
