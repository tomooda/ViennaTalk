Class {
	#name : #ViennaCasesExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
		          ifNil: [ aViennaAbstractFormatter empty ]
		          ifNotNil: [ :node |
			          aViennaAbstractFormatter empty ++ ','
			          ++ aViennaAbstractFormatter cr
			          ++ (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter indentString:
		  (aViennaAbstractFormatter keyword: 'cases ') ++ value ++ ':'
		  ++ String cr ++ alternatives ++ others ++ String cr
		  ++ (aViennaAbstractFormatter keyword: 'end')
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
	self casesExpressionAlternatives do: [ :alternative |
		alternative patternList do: [ :pattern |
			pattern maximalType: caseType ] ].

	^ self casesExpressionAlternatives typecheck
	  +
	  (self othersExpression
		   ifNotNil: #typecheck
		   ifNil: [ ViennaType unit ])
]

{ #category : #typechecking }
ViennaCasesExpressionNode >> maximalType: aViennaType [

	self casesExpressionAlternatives maximalType: aViennaType.
	self othersExpression ifNotNil: [ :exp |
		exp maximalType: aViennaType ].
	super maximalType: aViennaType
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression [
	^ self at: 3
]

{ #category : #accessing }
ViennaCasesExpressionNode >> othersExpression: aViennaOthersExpressionNode [

	self at: 3 put: aViennaOthersExpressionNode
]
