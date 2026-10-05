Class {
	#name : 'ViennaWriterListPresenter',
	#superclass : 'ViennaStateVariableReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaWriterListPresenter >> check: aViennaNode [

	^ aViennaNode isWriteAccess
]

{ #category : 'initialization' }
ViennaWriterListPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter title: 'Writers on ' , (targetName ifNotNil: #source ifNil: '-')
]
