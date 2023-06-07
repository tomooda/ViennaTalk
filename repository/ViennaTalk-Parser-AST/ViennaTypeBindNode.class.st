Class {
	#name : #ViennaTypeBindNode,
	#superclass : #ViennaBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeBindNode class >> pattern: aViennaPatternNode type: aViennaTypeNode [

	^ (self new: 2)
		  pattern: aViennaPatternNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: ':'
		  arg: (aViennaAbstractFormatter format: self type)
]

{ #category : #testing }
ViennaTypeBindNode >> isViennaTypeBindNode [

	^ true
]

{ #category : #accessing }
ViennaTypeBindNode >> label [

	^ 'TypeBind'
]

{ #category : #accessing }
ViennaTypeBindNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeBindNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
