Class {
	#name : #ViennaCasesExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesExpressionNode class >> expression: aViennaExpressionNode casesExpressionAlternatives: aViennaCasesExpressionAlternativesNode othersExpression: aViennaOthersExpressionNode [

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

{ #category : #'pretty printing' }
ViennaCasesExpressionNode >> formatWith: aViennaAbstractFormatter [

	| value alternatives others |
	value := aViennaAbstractFormatter format: self expression.
	alternatives := aViennaAbstractFormatter format:
		                self casesExpressionAlternatives.
	others := self othersExpression
		          ifNil: [ '' ]
		          ifNotNil: [ :node |
		          ',' , String cr , (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter indentString:
		  'cases ' , value , ':' , String cr , alternatives , others
		  , String cr , 'end'
]

{ #category : #private }
ViennaCasesExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self casesExpressionAlternatives
		freeIdentifiersExcept: aSet
		do: aBlock.
	self othersExpression ifNotNil: [ :others |
		others freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaCasesExpressionNode >> isViennaCasesExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaCasesExpressionNode >> label [

	^ 'CasesExpression'
]

{ #category : #typechecking }
ViennaCasesExpressionNode >> maximalType [

	| caseType |
	caseType := self expression typecheck.
	^ ViennaType
		  normalFormUnion: (Array streamContents: [ :stream |
				   self casesExpressionAlternatives do: [ :alternative |
					   alternative patternList do: [ :pattern |
						   pattern maximalType: caseType ].
					   stream nextPut: alternative expression typecheck ].
				   self othersExpression ifNotNil: [ :others |
					   stream nextPut: others expression typecheck ] ])
		  ifUnit: [ ViennaTypeError signalOn: self ]
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression [
	^ self at: 3
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression: aViennaOthersExpressionNode [

	self at: 3 put: aViennaOthersExpressionNode
]
