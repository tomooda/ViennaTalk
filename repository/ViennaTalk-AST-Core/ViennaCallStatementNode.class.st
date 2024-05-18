Class {
	#name : 'ViennaCallStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaCallStatementNode class >> name: aViennaNameNode expressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : 'accessing' }
ViennaCallStatementNode >> expressionList [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaCallStatementNode >> expressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : 'pretty printing' }
ViennaCallStatementNode >> formatWith: aViennaAbstractFormatter [

	| args |
	args := aViennaAbstractFormatter format: self expressionList.
	^ (aViennaAbstractFormatter format: self name) ++ '('
	  ++ ((aViennaAbstractFormatter needsIndent: args)
			   ifTrue: [ aViennaAbstractFormatter newlineIndentString: args ]
			   ifFalse: [ args ]) ++ ')'
]

{ #category : 'private' }
ViennaCallStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock.
	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaCallStatementNode >> isViennaCallStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaCallStatementNode >> label [

	^ 'CallStatement'
]

{ #category : 'typechecking' }
ViennaCallStatementNode >> maximalType [

	^ self name resolve
		  ifNotNil: [ :op |
			  op isOperationDefinition
				  ifTrue: [
					  | argtype |
					  argtype := op argumentType typecheck.
					  argtype isProductType
						  ifTrue: [
							  argtype basetypes size = self expressionList size
								  ifTrue: [
									  argtype basetypes
										  with: self expressionList
										  do: [ :ptype :arg | arg typecheck: ptype ].
									  op returnType typecheck ]
								  ifFalse: [
									  ViennaTypeError
										  on: self
										  signal:
											  'Num args mimatch: ' , argtype basetypes size printString
											  , ' parameters declared, but given '
											  , self expressionList source ] ]
						  ifFalse: [
							  argtype
								  ifNotUnit: [
									  self expressionList size = 1
										  ifTrue: [
											  self expressionList first typecheck: argtype.
											  op returnType typecheck ]
										  ifFalse: [
											  ViennaTypeError
												  on: self
												  signal:
													  'Num args mimatch: 1 parameter declared, but given '
													  , self expressionList source ] ]
								  ifUnit: [
									  self expressionList size = 0
										  ifTrue: [ op returnType typecheck ]
										  ifFalse: [
											  ViennaTypeError
												  on: self
												  signal:
													  'Num args mimatch: no parameter declared, but given '
													  , self expressionList source ] ] ] ]
				  ifFalse: [
					  ViennaTypeError
						  on: self
						  signal:
						  'The callee ' , self name source , ' is not an operation' ] ]
		  ifNil: [
			  ViennaTypeError
				  on: self
				  signal: 'Unresolved operation: ' , self name source ]
]

{ #category : 'accessing' }
ViennaCallStatementNode >> name [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaCallStatementNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
