Extension { #name : #PPExpressionParser }

{ #category : #'*ViennaTalk-Value-Core' }
PPExpressionParser >> precedence: aBlock do: actionBlock [
	parser := ((aBlock value: parser) ==> actionBlock) / parser
]
