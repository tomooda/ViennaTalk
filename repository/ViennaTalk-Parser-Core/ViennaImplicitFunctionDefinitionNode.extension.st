Extension { #name : 'ViennaImplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaImplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser current functionDefinition end
]
