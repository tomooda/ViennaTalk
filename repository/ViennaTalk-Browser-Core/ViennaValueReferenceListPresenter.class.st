Class {
	#name : 'ViennaValueReferenceListPresenter',
	#superclass : 'ViennaReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core',
	#package : 'ViennaTalk-Browser-Core'
}

{ #category : 'testing' }
ViennaValueReferenceListPresenter >> check: aViennaNode [

	^ aViennaNode isViennaNameNode and: [ self target == aViennaNode resolve ]
]

{ #category : 'initialization' }
ViennaValueReferenceListPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter title: 'References on ' , (targetName
			 ifNotNil: [ :name |
					 name resolve
						 ifNotNil: [ :def |
								 (def respondsTo: #globalNames)
									 ifTrue: [ def globalNames collect: #source ]
									 ifFalse: [
											 (def respondsTo: #identifier)
												 ifTrue: [ def identifier ]
												 ifFalse: [ '-' ] ] ]
						 ifNil: [ '-' ] ]
			 ifNil: '-')
]
