Class {
	#name : #ViennaSequenceEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSequenceEnumerationNode class >> withAll: anArrayOfViennaExpressionNode [

	| seq |
	seq := self new: anArrayOfViennaExpressionNode size.
	1 to: anArrayOfViennaExpressionNode size do: [ :index |
		seq at: index put: (anArrayOfViennaExpressionNode at: index) ].
	^ seq
]

{ #category : #accessing }
ViennaSequenceEnumerationNode >> label [

	^ 'SequenceEnumeration'
]
