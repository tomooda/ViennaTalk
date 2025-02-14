Extension { #name : 'ViennaImplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaImplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser new functionDefinition end
]
