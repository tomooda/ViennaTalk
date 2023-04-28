Class {
	#name : #ViennaSetEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetEnumerationNode class >> withAll: anArrayOfViennaExpressionNode [

	| set |
	set := self new: anArrayOfViennaExpressionNode size.
	1 to: anArrayOfViennaExpressionNode size do: [ :index |
		set at: index put: (anArrayOfViennaExpressionNode at: index) ].
	^ set
]

{ #category : #accessing }
ViennaSetEnumerationNode >> label [

	^ 'SetEnumeration'
]
