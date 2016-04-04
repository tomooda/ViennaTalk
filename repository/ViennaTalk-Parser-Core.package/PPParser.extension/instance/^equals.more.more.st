*ViennaTalk-Parser-Core
=>> aBlock
	"Answer a new parser that performs aBlock as action handler on success."

	^ ViennaPositionParser on: self block: aBlock