Class {
	#name : #ViennaTypeVariableIdentifierNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeVariableIdentifierNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeVariableIdentifierNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self string
]

{ #category : #testing }
ViennaTypeVariableIdentifierNode >> isViennaTypeVariableIdentifierNode [

	^ true
]

{ #category : #testing }
ViennaTypeVariableIdentifierNode >> isViennaTypeVariableIdentifierNode: aString [

	^ self string = aString
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> label [

	^ 'TypeVariableIdentifier'
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeVariableIdentifierNode >> string: aString [

	self at: 1 put: aString
]
