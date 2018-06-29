Extension { #name : #BlockClosure }

{ #category : #'*ViennaTalk-Value-Core' }
BlockClosure >> ** anInteger [
	^ ViennaIteration with: self with: anInteger
]

{ #category : #'*ViennaTalk-Value-Core' }
BlockClosure >> applyTo: anArray [
	^ self valueWithArguments: anArray
]

{ #category : #'*ViennaTalk-Value-Core' }
BlockClosure >> comp: applicative [
	^ ViennaComposition with: self with: applicative
]
