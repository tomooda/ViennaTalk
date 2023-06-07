Class {
	#name : #ViennaExceptionsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExceptionsNode class >> errorList: aViennaErrorListNode [

	^ (self new: 1)
		  errorList: aViennaErrorListNode;
		  yourself
]

{ #category : #accessing }
ViennaExceptionsNode >> errorList [

	^ self at: 1
]

{ #category : #accessing }
ViennaExceptionsNode >> errorList: aViennaErrorListNode [

	self at: 1 put: aViennaErrorListNode
]

{ #category : #'pretty printing' }
ViennaExceptionsNode >> formatWith: aViennaAbstractFormatter [

	^ 'errs' , (aViennaAbstractFormatter format: self errorList)
]

{ #category : #accessing }
ViennaExceptionsNode >> label [

	^ 'Exceptions'
]
