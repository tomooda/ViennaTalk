Extension { #name : 'ViennaExpressionNode' }

{ #category : '*ViennaTalk-Parser-Core' }
ViennaExpressionNode >> parser [

	^ ViennaVDMParser current expression end
]
