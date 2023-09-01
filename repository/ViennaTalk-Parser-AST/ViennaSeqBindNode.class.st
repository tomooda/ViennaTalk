Class {
	#name : #ViennaSeqBindNode,
	#superclass : #ViennaSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSeqBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: aViennaAbstractFormatter inseq
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaSeqBindNode >> isViennaSeqBindNode [

	^ true
]

{ #category : #accessing }
ViennaSeqBindNode >> label [

	^ 'SeqBind'
]
