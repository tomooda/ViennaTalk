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

{ #category : #private }
ViennaExceptionsNode >> boundIdentifiersDo: aBlock [

	self errorList boundIdentifiersDo: aBlock
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

{ #category : #private }
ViennaExceptionsNode >> freeIdentifiersExcept: aSet do: aBlock [

	self errorList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaExceptionsNode >> isViennaExceptionsNode [

	^ true
]

{ #category : #accessing }
ViennaExceptionsNode >> label [

	^ 'Exceptions'
]
