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

{ #category : 'accessing' }
ViennaCommandLineHandler class >> generateMacOS [

	<script: 'ViennaCommandLineHandler generateMacOS'>
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
				(#DeployPharoExpression -> 'ViennaLauncher deploy') } asDictionary;
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

	OSWindowDriver current startUp: true.
	OSPlatform current isMacOSX ifTrue: [
		| main |
		main := CocoaMenu new.
		main
			title: 'MainMenu';
			addSubmenu: 'ViennaTalk' with: [ :m |
				m
					addItemWithTitle: 'Settings...'
					action: [ ViennaLauncher showSettingBrowser ];
					addItemWithTitle: 'Quit'
					action: [ Smalltalk snapshot: false andQuit: true ]
					shortcut: 'q' ];
			addSubmenu: 'File' with: [ :m |
			m
				addItemWithTitle: 'Open Browsesr'
				action: [ ViennaRefactoringBrowser new open ];
				addItemWithTitle: 'Open Launcher'
				action: [ ViennaLauncher reopen ] ];
			addSubmenu: 'Help' with: [ :m |
			m
				addItemWithTitle: 'Show Help'
				action: [ self inform: 'Help' ]
				shortcut: '' ].
		main setAsMainMenu ]
]

{ #category : 'activation' }
ViennaCommandLineHandler >> installQuitSession [

	Smalltalk at: #WorldState ifPresent: [ :class |
		class class compile:
			'quitSession Smalltalk snapshot: false andQuit: true' ]
]
