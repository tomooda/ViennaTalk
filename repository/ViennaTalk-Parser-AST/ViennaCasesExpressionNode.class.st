Class {
	#name : #ViennaCasesExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesExpressionNode class >> expression: aViennaExpressionNode casesExpressionAlternatives: aViennaCasesExpressionAlternativesNode others: aViennaOthersExpressionNode [

	^ (self new: 3)
		  expression: aViennaExpressionNode;
		  casesExpressionAlternatives:
			  aViennaCasesExpressionAlternativesNode;
		  othersExpression: aViennaOthersExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaCasesExpressionNode >> casesExpressionAlternatives [
	^ self at: 2
]

{ #category : #accessing }
ViennaCasesExpressionNode >> casesExpressionAlternatives: aViennaCasesExpressionAlternativesNode [

	self at: 2 put: aViennaCasesExpressionAlternativesNode
]

{ #category : #accessing }
ViennaCasesExpressionNode >> expression [
	^ self at: 1
]

{ #category : #accessing }
ViennaCasesExpressionNode >> expression: aViennaExpression [

	self at: 1 put: aViennaExpression
]

{ #category : #accessing }
ViennaCasesExpressionNode >> label [

	^ 'CasesExpression'
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression [
	^ self at: 3
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression: aViennaOthersExpressionNode [

	self at: 3 put: aViennaOthersExpressionNode
]
