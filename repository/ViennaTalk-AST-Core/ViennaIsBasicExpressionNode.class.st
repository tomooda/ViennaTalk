Class {
	#name : #ViennaIsBasicExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
	^ aViennaAbstractFormatter empty
	  ++ (aViennaAbstractFormatter keyword: 'is_') ++ name ++ '('
	  ++ ((aViennaAbstractFormatter needsIndent: expression)
			   ifTrue: [
				   aViennaAbstractFormatter cr ++ aViennaAbstractFormatter indent
				   ++ (aViennaAbstractFormatter indentString: expression) ]
			   ifFalse: [ expression ]) ++ ')'
]

{ #category : #private }
ViennaIsBasicExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaIsBasicExpressionNode >> isViennaIsBasicExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaIsBasicExpressionNode >> label [

	^ 'IsBasicExpression'
]

{ #category : #typechecking }
ViennaIsBasicExpressionNode >> maximalType [

	self expression typecheck.
	^ ViennaType bool
]
