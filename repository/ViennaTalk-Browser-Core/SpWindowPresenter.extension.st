Extension { #name : 'SpWindowPresenter' }

{ #category : '*ViennaTalk-Browser-Core' }
SpWindowPresenter >> okToClose [

	^ presenter ifNotNil: #okToClose ifNil: [ super okToClose ]
]
