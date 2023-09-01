Class {
	#name : #ViennaSeqTypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSeqTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter seqPrefix
	  , (aViennaAbstractFormatter format: self type)
	  , aViennaAbstractFormatter seqPostfix
]

{ #category : #testing }
ViennaSeqTypeNode >> isViennaSeqTypeNode [

	^ true
]

{ #category : #accessing }
ViennaSeqTypeNode >> label [

	^ 'SeqType'
]

{ #category : #'pretty printing' }
ViennaSeqTypeNode >> operatorPrecedence [

	^ 5
]
