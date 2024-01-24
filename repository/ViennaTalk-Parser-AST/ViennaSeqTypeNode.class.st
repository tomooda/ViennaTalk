Class {
	#name : #ViennaSeqTypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaSeqTypeNode >> asMaximalViennaType [

	^ self type asMaximalViennaType seq
]

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
