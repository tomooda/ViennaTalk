Class {
	#name : #ViennaOperationBodyNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOperationBodyNode class >> isNotYetSpecified [

	^ self statementOrIsNotYetSpecified: ViennaIsNotYetSpecifiedNode new
]

{ #category : #'instance creation' }
ViennaOperationBodyNode class >> statement: aViennaStatementNode [

	^ (self new: 1)
		  statementOrIsNotYetSpecified: aViennaStatementNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaOperationBodyNode class >> statementOrIsNotYetSpecified: aViennaStatementNodeOrViennaIsNotYetSpecifiedNode [

	^ (self new: 1)
		  statementOrIsNotYetSpecified:
			  aViennaStatementNodeOrViennaIsNotYetSpecifiedNode;
		  yourself
]

{ #category : #private }
ViennaOperationBodyNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaOperationBodyNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self statementOrIsNotYetSpecified
]

{ #category : #testing }
ViennaOperationBodyNode >> isViennaOperationBodyNode [

	^ true
]

{ #category : #accessing }
ViennaOperationBodyNode >> label [

	^ 'OperationBody'
]

{ #category : #accessing }
ViennaOperationBodyNode >> statementOrIsNotYetSpecified [

	^ self at: 1
]

{ #category : #accessing }
ViennaOperationBodyNode >> statementOrIsNotYetSpecified: aViennaStatementNodeOrViennaIsNotYetSpecifiedNode [

	self at: 1 put: aViennaStatementNodeOrViennaIsNotYetSpecifiedNode
]
