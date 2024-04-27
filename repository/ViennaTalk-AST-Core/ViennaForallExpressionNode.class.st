Class {
	#name : #ViennaForallExpressionNode,
	#superclass : #ViennaMultipleBindQuantifierNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaForallExpressionNode class >> bindList: aViennaBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bindList: aViennaBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaForallExpressionNode >> formatWith: aViennaAbstractFormatter [

	| bindList expression |
	bindList := aViennaAbstractFormatter format: self first.
	expression := aViennaAbstractFormatter format: self second.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: aViennaAbstractFormatter forall
				   insertCrIfNeeded:
				   bindList trim , ' ' , aViennaAbstractFormatter dot)
		  insertCrIfNeeded: expression
]

{ #category : #accessing }
ViennaForallExpressionNode >> isViennaForallExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaForallExpressionNode >> label [

	^ 'ForallExpression'
]

{ #category : #'pretty printing' }
ViennaForallExpressionNode >> operatorPrecedence [

	^ 10
]
