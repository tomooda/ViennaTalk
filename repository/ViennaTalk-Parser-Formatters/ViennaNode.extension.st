Extension { #name : #ViennaNode }

{ #category : #'*ViennaTalk-Parser-Formatters' }
ViennaNode >> source [

	^ ViennaVDMFormatter format: self
]
