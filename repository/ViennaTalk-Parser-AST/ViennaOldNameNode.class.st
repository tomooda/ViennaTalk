Class {
	#name : #ViennaOldNameNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOldNameNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #accessing }
ViennaOldNameNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaOldNameNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaOldNameNode >> label [

	^ 'OldName'
]
