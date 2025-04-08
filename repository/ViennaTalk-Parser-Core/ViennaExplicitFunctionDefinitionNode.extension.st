Extension { #name : 'ViennaExplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser current functionDefinition end
]
