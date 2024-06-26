Class {
	#name : 'ViennaRecordConstructorNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaRecordConstructorNode class >> name: aViennaNameNode expressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> expressionList [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> expressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : 'pretty printing' }
ViennaRecordConstructorNode >> formatWith: aViennaAbstractFormatter [

	| constructor expressionList |
	constructor := aViennaAbstractFormatter format: self name.
	expressionList := aViennaAbstractFormatter format:
		                  self expressionList.
	^ (aViennaAbstractFormatter keyword: 'mk_') ++ constructor ++ '('
	  ++ ((aViennaAbstractFormatter needsIndent: expressionList)
			   ifTrue: [
				   aViennaAbstractFormatter cr ++ aViennaAbstractFormatter indent
				   ++ (aViennaAbstractFormatter indentString: expressionList) ]
			   ifFalse: [ expressionList ]) ++ ')'
]

{ #category : 'private' }
ViennaRecordConstructorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock.
	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> isViennaRecordConstructorNode [

	^ true
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> label [

	^ 'RecordConstructor'
]

{ #category : 'typechecking' }
ViennaRecordConstructorNode >> maximalType [

	^ (self name resolve ifNotNil: #typecheck)
		  ifNotNil: [ :recordType |
			  recordType size = self expressionList size
				  ifTrue: [
					  1 to: self expressionList size do: [ :index |
						  (self expressionList at: index) typecheck:
							  (recordType basetypeAt: index) ].
					  recordType ]
				  ifFalse: [
					  ViennaTypeError
						  on: self
						  signal:
							  'Wrong number of arguments: ' , recordType size printString
							  , ' declared but ' , self expressionList size printString
							  , ' given' ] ]
		  ifNil: [
			  ViennaTypeError
				  on: self
				  signal: 'Record type ' , self name source , ' is not defined' ]
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> name [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaRecordConstructorNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
