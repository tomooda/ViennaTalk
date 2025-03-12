Extension { #name : 'SpAbstractPresenter' }

{ #category : '*ViennaTalk-Browser-Core' }
SpAbstractPresenter >> font: aFont [
]

{ #category : '*ViennaTalk-Browser-Core' }
SpAbstractPresenter >> open [

	Smalltalk at: #ViennaLauncher ifPresent: [ :launcher |
		launcher isMultiWindowMode ifTrue: [
			^ self build
				  openInExternalWindow;
				  layoutFrame: (0 @ 0 extent: 1 @ 1);
				  yourself ] ].
	^ self asWindow open
]
