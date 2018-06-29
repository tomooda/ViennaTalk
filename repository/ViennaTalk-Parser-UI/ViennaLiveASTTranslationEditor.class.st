Class {
	#name : #ViennaLiveASTTranslationEditor,
	#superclass : #ViennaLiveTranslationEditor,
	#category : 'ViennaTalk-Parser-UI'
}

{ #category : #menu }
ViennaLiveASTTranslationEditor class >> VDM2SmalltalkTranslatorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM->AST translator')
		action: [ self new openWithSpec ];
		order: 0.471;
		parent: #Tools;
		help: 'VDM-SL to AST LIVE translating editor';
		icon: nil
]

{ #category : #accessing }
ViennaLiveASTTranslationEditor >> defaultTitle [
	^ 'VDM -> AST'
]

{ #category : #accessing }
ViennaLiveASTTranslationEditor >> format: aViennaNode [
	^ aViennaNode printString
]

{ #category : #'class access' }
ViennaLiveASTTranslationEditor >> translatorClass [
	^ ViennaVDMParser
]
