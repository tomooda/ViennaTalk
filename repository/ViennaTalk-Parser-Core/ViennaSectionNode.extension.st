Extension { #name : 'ViennaSectionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaSectionNode >> parser [

	^ ViennaVDMParser new definitionBlock end
]
