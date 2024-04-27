Class {
	#name : #ViennaIsNameExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaIsNameExpressionNode class >> name: aViennaNameNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaIsNameExpressionNode >> formatWith: aViennaAbstractFormatter [

	| name expression |
	name := aViennaAbstractFormatter format: self name.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter empty
	  , (aViennaAbstractFormatter keyword: 'is_') , name , '('
	  , ((aViennaAbstractFormatter needsIndent: expression)
			   ifTrue: [
				   aViennaAbstractFormatter cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: expression) ]
			   ifFalse: [ expression ]) , ')'
]

{ #category : #private }
ViennaIsNameExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self name freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> isViennaIsNameExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> label [

	^ 'IsNameExpression'
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> maximalType [

	self name resolve
		ifNotNil: [ :node |
			(node isViennaTypeSynonymNode or: [
				 node isViennaRecordTypeDefinitionNode ]) ifFalse: [
				ViennaTypeError
					on: self
					signal: self name source , ' is not a type name' ] ]
		ifNil: [
			ViennaTypeError
				on: self
				signal: 'Type name ' , self name source , ' could not be resolved' ].
	self expression typecheck.
	^ ViennaType bool
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaIsNameExpressionNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
