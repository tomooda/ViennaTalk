Class {
	#name : #ViennaSetBindNode,
	#superclass : #ViennaSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: aViennaAbstractFormatter inset
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaSetBindNode >> isViennaSetBindNode [

	^ true
]

{ #category : #accessing }
ViennaSetBindNode >> label [

	^ 'SetBind'
]
