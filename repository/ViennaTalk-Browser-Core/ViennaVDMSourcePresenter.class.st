Class {
	#name : #ViennaVDMSourcePresenter,
	#superclass : #SpCodePresenter,
	#category : #'ViennaTalk-Browser-Core-Browsers'
}

{ #category : #commands }
ViennaVDMSourcePresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [

	
]

{ #category : #initialization }
ViennaVDMSourcePresenter >> initialize [

	super initialize.
	self
		clearInteractionModel;
		overridingContextMenu;
		withoutSyntaxHighlight;
		withoutSmartCharacters
]
