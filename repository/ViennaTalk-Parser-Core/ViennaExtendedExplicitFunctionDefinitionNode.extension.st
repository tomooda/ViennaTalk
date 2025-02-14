Extension { #name : 'ViennaExtendedExplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExtendedExplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser new functionDefinition end
]
