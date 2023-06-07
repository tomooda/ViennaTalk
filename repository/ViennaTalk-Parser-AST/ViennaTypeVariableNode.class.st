Class {
	#name : #ViennaTypeVariableNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeVariableNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeVariableNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self string
]

{ #category : #testing }
ViennaTypeVariableNode >> isViennaTypeVariableNode [

	^ true
]

{ #category : #testing }
ViennaTypeVariableNode >> isViennaTypeVariableNode: aString [

	^ self string = aString
]

{ #category : #accessing }
ViennaTypeVariableNode >> label [

	^ 'TypeVariable'
]

{ #category : #accessing }
ViennaTypeVariableNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeVariableNode >> string: aString [

	self at: 1 put: aString
]
