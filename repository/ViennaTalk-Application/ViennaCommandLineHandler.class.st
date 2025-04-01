Class {
	#name : 'ViennaCommandLineHandler',
	#superclass : 'CommandLineHandler',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'accessing' }
ViennaCommandLineHandler class >> commandName [

	^ 'ViennaTalk'
]

{ #category : 'utilities' }
ViennaCommandLineHandler class >> deploy [

	<script>
	GraphicFontSettings setFontsToStyleNamed: #small.
	ViennaLauncher font: TextStyle defaultFont.
	ViennaLauncher setSingleWindowMode.
	Smalltalk cleanUp: true except: {  } confirming: false.
	MCRepositoryGroup allSubInstancesDo: [ :group |
		group repositories do: [ :repo | group removeRepository: repo ] ].
	IceRepository registry removeAll.
	IceCredentialStore current in: [ :store |
		store allCredentials do: [ :each | each removeFrom: store ] ].
	World closeAllWindowsDiscardingChanges.
	ViennaLauncher reopen.
	Deprecation
		raiseWarning: false;
		showWarning: false.
	NoChangesLog install.
	"NoPharoFilesOpener install."
	FFICompilerPlugin install.
	Stdio useNullStreams.
	MCCacheRepository uniqueInstance disable.
	EpMonitor reset.
	5 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : 'utilities' }
ViennaCommandLineHandler class >> generate [

	<script: 'ViennaCommandLineHandler generate'>
	PhleeterOnOSX new
		properties: {
				(#AppName -> 'ViennaTalk').
				(#InfoString -> 'VDM IDE on Pharo').
				(#BundleIdentifier -> 'org.viennatalk.ViennaTalk').
				(#ShortVersion -> BaselineOfViennaTalk codename).
				(#DisplayName -> ('ViennaTalk ' , BaselineOfViennaTalk codename)).
				(#CodesignName -> 'ViennaTalk').
				(#IconSetFile
				 ->
					 ((IceRepository repositoryNamed: 'ViennaTalk') location
					  / 'resources' / 'ViennaTalk.icns')).
				(#DiskIconSetFile
				 ->
					 ((IceRepository repositoryNamed: 'ViennaTalk') location
					  / 'resources' / 'disk.icns')).
				(#CommandLineHandler -> self commandName).
				(#CompanyName -> 'ViennaTalk project').
				(#DeployPharoExpression -> 'ViennaCommandLineHandler deploy') }
				asDictionary;
		outputDirectory: FileLocator home / 'src' / 'ViennaTalk' / 'build';
		targetPlatforms:
			#( 'Darwin-arm64' 'Darwin-x86_64' 'Windows-x86_64' );
		addExternalFile:
			(IceRepository repositoryNamed: 'ViennaTalk') location
			/ 'resources' / 'ViennaTalk-logo-transparent.png'
		destination: 'pharo-local/ViennaTalk/ViennaTalk-logo.png';
		generate
]

{ #category : 'activation' }
ViennaCommandLineHandler >> activate [

	self
		installMenu;
		installQuitSession
]

{ #category : 'activation' }
ViennaCommandLineHandler >> installMenu [

	<script: 'ViennaCommandLineHandler new installMenu'>
	OSWindowDriver current startUp: true.
	OSPlatform current isMacOSX ifTrue: [
		| main |
		main := CocoaMenu new.
		main
			title: 'MainMenu';
			add: ViennaLauncher current systemMenu asCocoaMenu;
			addSubmenu: 'File' with: [ :m |
				m
					addItemWithTitle: 'Open Browsesr'
					action: [ ViennaRefactoringBrowser new open ];
					addItemWithTitle: 'Open Launcher'
					action: [ ViennaLauncher reopen ] ];
			add: ViennaLauncher current toolsMenu asCocoaMenu;
			addSubmenu: 'Help' with: [ :m |
			m
				addItemWithTitle: 'ViennaTalk docs'
				action: [MicDocumentBrowserPresenter openDocument: 'github://tomooda/ViennaTalk:main/docs']
				shortcut: '' ].
		main setAsMainMenu ]
]

{ #category : 'activation' }
ViennaCommandLineHandler >> installQuitSession [

	Smalltalk at: #WorldState ifPresent: [ :class |
		class class compile:
			'quitSession Smalltalk snapshot: false andQuit: true' ]
]
