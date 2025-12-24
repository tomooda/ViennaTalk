Extension { #name : 'ViennaTypeSynonymNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaTypeSynonymNode >> parser [

	^ ViennaVDMParser current typeDefinition
]
