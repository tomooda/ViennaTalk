Class {
	#name : #ViennaMapOrSequenceModifyNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression1: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression2: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceModifyNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter override
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> isViennaMapOrSequenceModifyNode [

	^ true
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> label [

	^ 'MapOrSequenceModify'
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> paramType1 [

	^ (ViennaType any mapTo: ViennaType any) | ViennaType any seq
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> paramType2 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	aViennaType1 isMapType ifTrue: [
		aViennaType2 isMapType ifTrue: [
			^ (aViennaType1 keytype >= aViennaType2 keytype
				   ifTrue: [ aViennaType1 keytype ]
				   ifFalse: [
					   aViennaType2 keytype >= aViennaType1 keytype
						   ifTrue: [ aViennaType2 keytype ]
						   ifFalse: [ aViennaType1 keytype | aViennaType2 keytype ] ]) mapTo:
				  (aViennaType1 valuetype >= aViennaType2 valuetype
					   ifTrue: [ aViennaType1 valuetype ]
					   ifFalse: [
						   aViennaType2 valuetype >= aViennaType1 valuetype
							   ifTrue: [ aViennaType2 valuetype ]
							   ifFalse: [ aViennaType1 valuetype | aViennaType2 valuetype ] ]) ] ].
	aViennaType1 isSeqType ifTrue: [
		aViennaType2 isMapType ifTrue: [
			^ (aViennaType1 basetype >= aViennaType2 valuetype
				   ifTrue: [ aViennaType1 basetype ]
				   ifFalse: [
					   aViennaType2 valuetype >= aViennaType1 basetype
						   ifTrue: [ aViennaType2 valuetype ]
						   ifFalse: [ aViennaType1 basetype | aViennaType2 valuetype ] ]) seq ] ].
	^ ViennaTypeError signalOn: self
]
