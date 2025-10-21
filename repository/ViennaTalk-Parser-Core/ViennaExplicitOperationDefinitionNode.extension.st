Extension { #name : 'ViennaExplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser current accessOperationDefinition end
]
