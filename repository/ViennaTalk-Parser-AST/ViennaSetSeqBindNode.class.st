Class {
	#name : #ViennaSetSeqBindNode,
	#superclass : #ViennaBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSetSeqBindNode >> pattern [

	^ self at: 1
]
