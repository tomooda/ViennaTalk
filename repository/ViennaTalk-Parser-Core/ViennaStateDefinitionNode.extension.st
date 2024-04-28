Extension { #name : #ViennaStateDefinitionNode }

{ #category : #'*ViennaTalk-Parser-Core' }
ViennaStateDefinitionNode >> parser [

	^ ViennaVDMParser new stateDefinition end
]
