Class {
	#name : 'ViennaValueReferenceListPresenter',
	#superclass : 'ViennaReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaValueReferenceListPresenter >> check: aViennaNode [

	^ aViennaNode isViennaNameNode and: [ target == aViennaNode resolve ]
]

{ #category : 'initialization' }
ViennaValueReferenceListPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter title: 'References on ' , (target
			 ifNotNil: [ :def |
					 (def respondsTo: #globalNames)
						 ifTrue: [ ', ' join: (def globalNames collect: #source) ]
						 ifFalse: [
								 (def respondsTo: #identifier)
									 ifTrue: [ def identifier ]
									 ifFalse: [ '-' ] ] ]
			 ifNil: [ '-' ])
]
