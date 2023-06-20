Class {
	#name : #ViennaTrapStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTrapStatementNode class >> pattern: aViennaPatternNode handlerStatement: aViennaStatementNode1 statement: aViennaStatementNode2 [

	^ (self new: 3)
		  pattern: aViennaPatternNode;
		  handlerStatement: aViennaStatementNode1;
		  statement: aViennaStatementNode2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTrapStatementNode >> formatWith: aViennaAbstractFormatter [

	| pattern handler statement |
	pattern := aViennaAbstractFormatter format: self pattern.
	handler := aViennaAbstractFormatter format: self handlerStatement.
	statement := aViennaAbstractFormatter format: self statement.
	^ (aViennaAbstractFormatter needsIndent: pattern)
		  ifTrue: [
			  (aViennaAbstractFormatter indentString: 'trap' insertCr: pattern)
			  , String cr
			  ,
			  (aViennaAbstractFormatter indentString: 'with' insertCr: handler)
			  , String cr
			  ,
			  (aViennaAbstractFormatter indentString: 'in' insertCr: statement) ]
		  ifFalse: [
			  | trap |
			  trap := 'trap ' , pattern.
			  (aViennaAbstractFormatter needsIndent: trap , handler)
				  ifTrue: [
					  trap , String cr
					  ,
					  (aViennaAbstractFormatter
						   indentString: 'with'
						   insertCr: handler) , String cr
					  ,
					  (aViennaAbstractFormatter
						   indentString: 'in'
						   insertCr: statement) ]
				  ifFalse: [
					  trap := trap , ' with ' , handler.
					  (aViennaAbstractFormatter needsIndent: trap , statement)
						  ifTrue: [
							  trap , String cr
							  ,
							  (aViennaAbstractFormatter
								   indentString: 'in'
								   insertCr: statement) ]
						  ifFalse: [ trap , ' in ' , statement ] ] ]
]

{ #category : #accessing }
ViennaTrapStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self statement freeIdentifiersExcept: aSet do: aBlock.
	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self handlerStatement
		freeIdentifiersExcept: aSet , self pattern uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #accessing }
ViennaTrapStatementNode >> handlerStatement [

	^ self at: 2
]

{ #category : #accessing }
ViennaTrapStatementNode >> handlerStatement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]

{ #category : #testing }
ViennaTrapStatementNode >> isViennaTrapStatementNode [

	^ true
]

{ #category : #accessing }
ViennaTrapStatementNode >> label [

	^ 'TrapStatement'
]

{ #category : #accessing }
ViennaTrapStatementNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaTrapStatementNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaTrapStatementNode >> statement [

	^ self at: 3
]

{ #category : #accessing }
ViennaTrapStatementNode >> statement: aViennaStatementNode [

	self at: 3 put: aViennaStatementNode
]
