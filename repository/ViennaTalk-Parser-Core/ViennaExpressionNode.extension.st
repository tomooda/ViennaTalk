Extension { #name : 'ViennaExpressionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExpressionNode >> parser [

	^ ViennaVDMParser new expression end
]
