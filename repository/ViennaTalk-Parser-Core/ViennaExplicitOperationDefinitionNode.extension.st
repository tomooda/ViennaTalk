Extension { #name : #ViennaExplicitOperationDefinitionNode }

{ #category : #'*ViennaTalk-Parser-Core' }
ViennaExplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser new operationDefinition end
]
