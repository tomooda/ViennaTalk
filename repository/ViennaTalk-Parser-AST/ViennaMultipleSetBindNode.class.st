Class {
	#name : #ViennaMultipleSetBindNode,
	#superclass : #ViennaMultipleSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMultipleSetBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: aViennaAbstractFormatter inset
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaMultipleSetBindNode >> isViennaMultipleSetBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleSetBindNode >> label [

	^ 'MultipleSetBind'
]
