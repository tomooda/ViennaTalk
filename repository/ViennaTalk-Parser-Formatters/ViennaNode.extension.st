Extension { #name : #ViennaNode }

{ #category : #'*ViennaTalk-Parser-Formatters' }
ViennaNode >> format [
	^ ViennaVDMFormatter new format: self
]

{ #category : #'*ViennaTalk-Parser-Formatters' }
ViennaNode >> formatWidth: anInteger [
	^ ViennaVDMFormatter new
		maxSizePerLine: anInteger;
		format: self
]
