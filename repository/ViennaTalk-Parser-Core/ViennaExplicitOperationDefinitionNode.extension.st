Extension { #name : 'ViennaExplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser current operationDefinition end
]
