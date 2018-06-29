Class {
	#name : #ViennaLiveSmalltalkTranslationEditor,
	#superclass : #ViennaLiveTranslationEditor,
	#category : 'ViennaTalk-Parser-UI'
}

{ #category : #menu }
ViennaLiveSmalltalkTranslationEditor class >> VDM2SmalltalkTranslatorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM->Smalltalk translator')
		action: [ self new openWithSpec ];
		order: 0.47;
		parent: #Tools;
		help: 'VDM-SL to Smalltalk LIVE translating editor';
		icon: nil
]

{ #category : #'class access' }
ViennaLiveSmalltalkTranslationEditor >> translatorClass [
	^ ViennaVDM2SmalltalkTranslator
]
