Class {
	#name : #ViennaSeq1TypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #converting }
ViennaSeq1TypeNode >> asMaximalViennaType [

	^ self type asMaximalViennaType seq1
]

{ #category : #'pretty printing' }
ViennaSeq1TypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter seq1Prefix
	  , (aViennaAbstractFormatter format: self type)
	  , aViennaAbstractFormatter seq1Postfix
]

{ #category : #testing }
ViennaSeq1TypeNode >> isViennaSeq1TypeNode [

	^ true
]

{ #category : #accessing }
ViennaSeq1TypeNode >> label [

	^ 'Seq1Type'
]

{ #category : #'pretty printing' }
ViennaSeq1TypeNode >> operatorPrecedence [

	^ 5
]
