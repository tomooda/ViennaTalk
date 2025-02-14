Extension { #name : 'ViennaValueDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaValueDefinitionNode >> parser [

	^ ViennaVDMParser new valueDefinition
]
