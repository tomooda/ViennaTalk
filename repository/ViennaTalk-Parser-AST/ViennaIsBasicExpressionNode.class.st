Class {
	#name : #ViennaIsBasicExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIsBasicExpressionNode class >> basicTypeName: aString expression: aViennaExpressionNode [

	^ (self new: 2)
		  basicTypeName: aString;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> basicTypeName [

	^ self at: 1
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> basicTypeName: aString [

	self at: 1 put: aString
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-types' }
ViennaIsBasicExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaIsBasicExpressionNode >> formatWith: aViennaAbstractFormatter [

	| name expression |
	name := aViennaAbstractFormatter format: self basicTypeName.
	expression := aViennaAbstractFormatter format: self expression.
	^ 'is_' , name , '('
	  , ((aViennaAbstractFormatter needsIndent: expression)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: expression) ]
			   ifFalse: [ expression ]) , ')'
]

{ #category : #accessing }
ViennaIsBasicExpressionNode >> label [

	^ 'IsBasicExpression'
]
