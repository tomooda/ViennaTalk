Class {
	#name : #ViennaRecordConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaRecordConstructorNode class >> name: aViennaNameNode expressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaRecordConstructorNode >> expressionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaRecordConstructorNode >> expressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : #accessing }
ViennaRecordConstructorNode >> label [

	^ 'RecordConstructor'
]

{ #category : #accessing }
ViennaRecordConstructorNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaRecordConstructorNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
