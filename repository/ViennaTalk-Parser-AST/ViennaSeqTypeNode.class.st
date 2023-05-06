Class {
	#name : #ViennaSeqTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSeqTypeNode >> label [

	^ 'SeqType'
]

{ #category : #'pretty printing' }
ViennaSeqTypeNode >> operatorPrecedence [

	^ 5
]
