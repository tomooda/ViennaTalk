Class {
	#name : #ViennaSeq1TypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSeq1TypeNode >> label [

	^ 'Seq1Type'
]

{ #category : #'pretty printing' }
ViennaSeq1TypeNode >> operatorPrecedence [

	^ 5
]
