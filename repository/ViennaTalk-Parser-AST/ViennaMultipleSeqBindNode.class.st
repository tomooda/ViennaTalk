Class {
	#name : #ViennaMultipleSeqBindNode,
	#superclass : #ViennaMultipleSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMultipleSeqBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: aViennaAbstractFormatter inseq
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaMultipleSeqBindNode >> isViennaMultipleSeqBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleSeqBindNode >> label [

	^ 'MultipleSeqBind'
]
