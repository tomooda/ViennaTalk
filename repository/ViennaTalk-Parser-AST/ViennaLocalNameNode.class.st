Class {
	#name : #ViennaLocalNameNode,
	#superclass : #ViennaNameNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLocalNameNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #accessing }
ViennaLocalNameNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaLocalNameNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaLocalNameNode >> label [

	^ 'LocalName'
]
