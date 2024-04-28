Extension { #name : #ViennaExplicitFunctionDefinitionNode }

{ #category : #'*ViennaTalk-Parser-Core' }
ViennaExplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser new functionDefinition end
]
