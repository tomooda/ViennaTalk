Class {
	#name : 'ViennaTalkApplication',
	#superclass : 'ClapApplication',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'deploying' }
ViennaTalkApplication class >> deploy [

	"GraphicFontSettings setFontsToStyleNamed: #small."
	PasteUpMorph shouldShowWorldMenu: false.
	MenubarMorph showMenubar: false.
	ViennaLauncher deploy.
	Smalltalk cleanUp: true except: {  }.
	MCRepositoryGroup allSubInstancesDo: [ :group | group repositories do: [ :repo | group removeRepository: repo ] ].
	IceRepository registry removeAll.
	IceCredentialStore current in: [ :store | store allCredentials do: [ :each | each removeFrom: store ] ].
	World closeAllWindowsDiscardingChanges.
	Deprecation
		raiseWarning: false;
		showWarning: false.
	NoSourcesManager beCurrent.
	"NoPharoFilesOpener install."
	Stdio useNullStreams.
	MCCacheRepository uniqueInstance disable.
	EpMonitor reset.
	SystemResolver flushUserLocalDirectory.
	5 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : 'commandline' }
ViennaTalkApplication class >> viennatalk [

	<commandline>
	^ (ClapCommandSpec id: #ViennaTalk)
		  description: 'IDE for VDM-SL';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'execution' }
ViennaTalkApplication >> execute [

	self
		installLocalDirectory;
		installMenu;
		installQuitSession.
	ViennaLauncher loadSettings
]

{ #category : 'installing' }
ViennaTalkApplication >> installLocalDirectory [

	SystemResolver userLocalDirectory:
		FileLocator viennaTalkDocumentDirectory
]

{ #category : 'installing' }
ViennaTalkApplication >> installMenu [

	<script: 'ViennaCommandLineHandler new installMenu'>
	OSWindowDriver current startUp: true
]

{ #category : 'installing' }
ViennaTalkApplication >> installQuitSession [

	Smalltalk at: #WorldState ifPresent: [ :class |
		class class compile:
			'quitSession Smalltalk snapshot: false andQuit: true' ]
]
