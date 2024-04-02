Extension { #name : #SpAbstractListPresenter }

{ #category : #'*ViennaTalk-Browser-Core' }
SpAbstractListPresenter >> items: aSequenceableCollection selectsFirst: aBoolean [

	model collection: aSequenceableCollection.
	aBoolean = true
		ifTrue: [ self selectIndex: 1 ]
		ifFalse: [ self unselectAll ]
]
