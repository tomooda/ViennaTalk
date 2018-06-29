Extension { #name : #PPParser }

{ #category : #'*ViennaTalk-Parser-Core' }
PPParser >> =>> aBlock [
	"Answer a new parser that performs aBlock as action handler on success."

	^ ViennaPositionParser on: self block: aBlock
]
