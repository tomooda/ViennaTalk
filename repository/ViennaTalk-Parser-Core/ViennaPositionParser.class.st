Class {
	#name : 'ViennaPositionParser',
	#superclass : 'PP2AbstractActionNode',
	#category : 'ViennaTalk-Parser-Core',
	#package : 'ViennaTalk-Parser-Core'
}

{ #category : 'initialization' }
ViennaPositionParser >> resetStrategy [
	strategy := ViennaPositionAction on: self
]
