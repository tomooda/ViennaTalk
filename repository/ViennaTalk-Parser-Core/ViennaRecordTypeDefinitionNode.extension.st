Extension { #name : 'ViennaRecordTypeDefinitionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaRecordTypeDefinitionNode >> parser [

	^ ViennaVDMParser new typeDefinition end
]
