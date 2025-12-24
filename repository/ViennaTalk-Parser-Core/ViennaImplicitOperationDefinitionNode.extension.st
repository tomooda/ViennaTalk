Extension { #name : 'ViennaImplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaImplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser current accessOperationDefinition end
]
