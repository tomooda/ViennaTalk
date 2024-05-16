Class {
	#name : 'ViennaLiveASTTranslationEditor',
	#superclass : 'ViennaLiveTranslationEditor',
	#category : 'ViennaTalk-Parser-UI',
	#package : 'ViennaTalk-Parser-UI'
}

{ #category : 'class initialization' }
ViennaLiveASTTranslationEditor class >> initialize [
	super initialize.
	Smalltalk at: #ViennaLauncher ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : 'menu' }
ViennaLiveASTTranslationEditor class >> viennaDevMenuOn: aBuilder [

	<ViennaDev>
	(aBuilder item: #'VDM->AST translator')
		action: [ self new open ];
		order: 0.2;
		help: 'VDM-SL to AST LIVE translating editor';
		icon: nil
]

{ #category : 'menu' }
ViennaLiveASTTranslationEditor class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ViennaTalkObsolete)
		label: 'obsolete';
		parent: #ViennaTalk;
		order: 1.1;
		withSeparatorAfter;
		with: [
			(aBuilder item: #'VDM->AST translator')
				action: [ self new open ];
				order: 0.1;
				help: 'VDM-SL to AST LIVE translating editor';
				icon: nil ]
]

{ #category : 'private' }
ViennaLiveASTTranslationEditor >> createTranslator [
	| parser |
	parser := ViennaVDMParser new.
	^ [ :string | parser document end / parser statement end / parser expression end parse: string ]
]

{ #category : 'accessing' }
ViennaLiveASTTranslationEditor >> defaultTitle [
	^ 'VDM -> AST'
]

{ #category : 'accessing' }
ViennaLiveASTTranslationEditor >> format: aViennaNode [
	^ aViennaNode printString
]

{ #category : 'initialize-release' }
ViennaLiveASTTranslationEditor >> initializeWidgets [
	super initializeWidgets.
	targetText help: 'AST'
]
