Extension { #name : 'PP2Node' }

{ #category : '*ViennaTalk-Parser-Core' }
PP2Node >> =>> aBlock [
	"Answer a new parser that performs aBlock as action handler on success."

	^ ViennaPositionParser on: self block: aBlock
]

{ #category : '*ViennaTalk-Parser-Core' }
PP2Node >> plusA [
	^ self plus ==> #asArray
]

{ #category : '*ViennaTalk-Parser-Core' }
PP2Node >> starA [
	^ self star ==> #asArray
]

{ #category : '*ViennaTalk-Parser-Core' }
PP2Node >> withoutSeparators [
	^ self
		==> [ :items | 
			| result |
			result := Array new: (items size + 1) // 2.
			1 to: result size do: [ :index | result at: index put: (items at: 2 * index - 1) ].
			result ]
]
