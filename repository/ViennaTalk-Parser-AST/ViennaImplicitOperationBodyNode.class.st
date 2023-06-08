Class {
	#name : #ViennaImplicitOperationBodyNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaImplicitOperationBodyNode class >> externals: aViennaExternalsNode pre: aViennaExpression1 post: aViennaExpression2 exceptions: aViennaExceptionsNode [

	^ (self new: 4)
		  externals: aViennaExternalsNode;
		  pre: aViennaExpression1;
		  post: aViennaExpression2;
		  exceptions: aViennaExceptionsNode;
		  yourself
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> exceptions [

	^ self at: 4
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> exceptions: aViennaExceptionsNode [

	self at: 4 put: aViennaExceptionsNode
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> externals [

	^ self at: 1
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> externals: aViennaExternalsNode [

	self at: 1 put: aViennaExternalsNode
]

{ #category : #'pretty printing' }
ViennaImplicitOperationBodyNode >> formatWith: aViennaAbstractFormatter [

	^ (self externals
		   ifNotNil: [ :externals |
			   String cr , (aViennaAbstractFormatter format: externals) ]
		   ifNil: [ '' ]) , (self pre
		   ifNotNil: [ :pre |
		   String cr , 'pre ' , (aViennaAbstractFormatter format: pre) ]
		   ifNil: [ '' ]) , (self post
		   ifNotNil: [ :post |
			   String cr , 'post ' , (aViennaAbstractFormatter format: post) ]
		   ifNil: [ '' ]) , (self exceptions
		   ifNotNil: [ :exceptions |
			   String cr , (aViennaAbstractFormatter format: exceptions) ]
		   ifNil: [ '' ])
]

{ #category : #'as yet unclassified' }
ViennaImplicitOperationBodyNode >> isViennaImplicitOperationBodyNode [

	^ true
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> label [

	^ 'ImplicitOperationBody'
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> post [

	^ self at: 3
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> post: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> pre [

	^ self at: 2
]

{ #category : #accessing }
ViennaImplicitOperationBodyNode >> pre: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
