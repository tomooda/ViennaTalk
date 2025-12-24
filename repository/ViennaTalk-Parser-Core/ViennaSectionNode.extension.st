Extension { #name : 'ViennaSectionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaSectionNode >> parser [

	^ ViennaVDMParser current definitionBlock end
]
