Class {
	#name : 'ViennaReaderListPresenter',
	#superclass : 'ViennaStateVariableReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaReaderListPresenter >> check: aViennaNode [

	^ aViennaNode isReadAccess
]

{ #category : 'initialization' }
ViennaReaderListPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter title: 'Readers on ' , (target ifNotNil: #identifier ifNil: '-')
]
