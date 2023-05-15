Class {
	#name : #ViennaSymbolicLiteralNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSymbolicLiteralNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> label [

	^ 'SymbolicLiteral'
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string: aString [

	self at: 1 put: aString
]