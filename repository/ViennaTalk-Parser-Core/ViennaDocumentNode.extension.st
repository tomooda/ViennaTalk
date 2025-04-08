Extension { #name : 'ViennaDocumentNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaDocumentNode >> parser [

	^ ViennaVDMParser current document end
]
