Extension { #name : 'ViennaStatementNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaStatementNode >> parser [

	^ ViennaVDMParser new statement end
]
