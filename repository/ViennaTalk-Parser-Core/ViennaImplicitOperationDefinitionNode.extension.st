Extension { #name : 'ViennaImplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaImplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser new operationDefinition end
]
