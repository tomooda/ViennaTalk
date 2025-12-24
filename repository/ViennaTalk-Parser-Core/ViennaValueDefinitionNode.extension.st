Extension { #name : 'ViennaValueDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaValueDefinitionNode >> parser [

	^ ViennaVDMParser current valueDefinition
]
