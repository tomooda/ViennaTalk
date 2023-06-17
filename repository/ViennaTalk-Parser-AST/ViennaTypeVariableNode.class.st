Class {
	#name : #ViennaTypeVariableNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeVariableNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeVariableNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self identifier
]

{ #category : #accessing }
ViennaTypeVariableNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeVariableNode >> identifier: aString [

	self at: 1 put: aString
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
