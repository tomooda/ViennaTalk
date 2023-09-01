Class {
	#name : #ViennaLiveASTTranslationEditor,
	#superclass : #ViennaLiveTranslationEditor,
	#category : #'ViennaTalk-Parser-UI'
}

{ #category : #menu }
ViennaLiveASTTranslationEditor class >> VDM2SmalltalkTranslatorMenuOn: aBuilder [

	<worldMenu>
	((aBuilder item: #VienntaTalkDev)
		 parent: #ViennaTalk;
		 label: 'dev')
		withSeparatorAfter;
		with: [ 
			(aBuilder item: #'VDM->AST translator')
				action: [ self new open ];
				order: 0.1;
				parent: #VienntaTalkDev;
				help: 'VDM-SL to AST LIVE translating editor';
				icon: nil ]
]

{ #category : #'class initialization' }
ViennaLiveASTTranslationEditor class >> initialize [
	super initialize.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : #menu }
ViennaLiveASTTranslationEditor class >> viennaDevMenuOn: aBuilder [

	<ViennaDev>
	(aBuilder item: #'VDM->AST translator')
		action: [ self new open ];
		order: 0.1;
		help: 'VDM-SL to AST LIVE translating editor';
		icon: nil
]

{ #category : #private }
ViennaLiveASTTranslationEditor >> createTranslator [
	| parser |
	parser := ViennaVDMParser new.
	^ [ :string | parser document end / parser statement end / parser expression end parse: string ]
]

{ #category : #accessing }
ViennaLiveASTTranslationEditor >> defaultTitle [
	^ 'VDM -> AST'
]

{ #category : #accessing }
ViennaLiveASTTranslationEditor >> format: aViennaNode [
	^ aViennaNode printString
]

{ #category : #'initialize-release' }
ViennaLiveASTTranslationEditor >> initializeWidgets [
	super initializeWidgets.
	targetText help: 'AST'
]
