Class {
	#name : #ConfigurationOfViennaTalk,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfViennaTalk'
}

{ #category : #'development support' }
ConfigurationOfViennaTalk class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfViennaTalk class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfViennaTalk class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfViennaTalk class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfViennaTalk class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfViennaTalk class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfViennaTalk class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfViennaTalk class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #testing }
ConfigurationOfViennaTalk class >> possiblyNewerVersions [
	^ (MCPackage named: self package name) workingCopy possiblyNewerVersions
]

{ #category : #accessing }
ConfigurationOfViennaTalk class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfViennaTalk class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline010: spec [
	<version: '0.10-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-WeblyWalkThrough-Translators' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' #'ViennaTalk-WeblyWalkThrough-Server' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline011: spec [
	<version: '0.11-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-WeblyWalkThrough-Translators' ). ];
			package: #'ViennaTalk-Launcher-Core'.
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' #'ViennaTalk-WeblyWalkThrough-Server' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline012: spec [
	<version: '0.12-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-WeblyWalkThrough-Translators' ). ];
			package: #'ViennaTalk-Launcher-Core';
			package: #'ViennaTalk-Parser-Code Generators' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Parser-Formatters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Parser-Highlighters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-Parser-Code Generators' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' #'ViennaTalk-WeblyWalkThrough-Server' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline013: spec [
	<version: '0.13-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
			spec
				project: 'NeoJSON'
					with: [ 
							spec
								className: #ConfigurationOfNeoJSON;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
				project: 'OSProcess'
					with: [ 
							spec
								className: #ConfigurationOfOSProcess;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
				project: 'ZincHTTPComponents'
					with: [ 
							spec
								className: #ConfigurationOfZincHTTPComponents;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
								repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
				project: 'PetitParser'
					with: [ 
							spec
								className: #ConfigurationOfPetitParser;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
			spec
				package: #'ViennaTalk-Engine-Core' with: [ spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents') ];
				package: #'ViennaTalk-Engine-Tests' with: [ spec requires: #(#'ViennaTalk-Engine-Core') ];
				package: #'ViennaTalk-Value-Core';
				package: #'ViennaTalk-VDMC-Core' with: [ spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-VDMC-Tests' with: [ spec requires: #(#'ViennaTalk-VDMC-Core') ];
				package: #'ViennaTalk-Value-Tests' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: 'ViennaTalk-Html-Core' with: [ spec requires: #('PetitParser') ];
				package: #'ViennaTalk-VDMPad-Core'
					with: [ spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents') ];
				package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-Type-Core';
				package: #'ViennaTalk-Parser-Core' with: [ spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core') ];
				package: #'ViennaTalk-Parser-UI' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: 'ViennaTalk-Parser-Tests' with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI') ];
				package: #'ViennaTalk-Type-Tests' with: [ spec requires: #(#'ViennaTalk-Type-Core') ];
				package: #'ViennaTalk-WeblyWalkThrough-Translators'
					with: [ spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON') ];
				package: #'ViennaTalk-WeblyWalkThrough-Server'
					with: [ spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-WeblyWalkThrough-Translators') ];
				package: #'ViennaTalk-Launcher-Core';
				package: #'ViennaTalk-Parser-Code Generators' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: #'ViennaTalk-Parser-Formatters' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: #'ViennaTalk-Parser-Highlighters' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: 'ViennaTalk-Browser-Core'
					with: [ 
							spec
								requires:
									#(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters') ];
				package: 'ViennaTalk-LivelyWalkThrough-Core'
					with: [ spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core') ].
			spec
				group: 'core'
					with:
						#(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-Parser-Code Generators' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters');
				group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core');
				group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core');
				group: 'tests'
					with:
						#(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests');
				group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough');
				group: 'default' with: #('full');
				group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets');
				group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' #'ViennaTalk-WeblyWalkThrough-Server') ]
]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline014: spec [
	<version: '0.14-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-WeblyWalkThrough-Translators' ). ];
			package: #'ViennaTalk-Launcher-Core';
			package: #'ViennaTalk-Parser-Code Generators' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Parser-Formatters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Parser-Highlighters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-Parser-Code Generators' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' #'ViennaTalk-WeblyWalkThrough-Server' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'tests' );
			group: 'default' with: #('full' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'tests' );
			group: 'default' with: #('full' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline05: spec [
	<version: '0.5-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline06: spec [
	<version: '0.6-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
			spec
				project: 'NeoJSON'
					with: [ 
							spec
								className: #ConfigurationOfNeoJSON;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
				project: 'OSProcess'
					with: [ 
							spec
								className: #ConfigurationOfOSProcess;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
				project: 'ZincHTTPComponents'
					with: [ 
							spec
								className: #ConfigurationOfZincHTTPComponents;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
								repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
				project: 'PetitParser'
					with: [ 
							spec
								className: #ConfigurationOfPetitParser;
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
			spec
				package: #'ViennaTalk-Engine-Core' with: [ spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents') ];
				package: #'ViennaTalk-Engine-Tests' with: [ spec requires: #(#'ViennaTalk-Engine-Core') ];
				package: #'ViennaTalk-Value-Core';
				package: #'ViennaTalk-VDMC-Core' with: [ spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-VDMC-Tests' with: [ spec requires: #(#'ViennaTalk-VDMC-Core') ];
				package: #'ViennaTalk-Value-Tests' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: 'ViennaTalk-Html-Core' with: [ spec requires: #('PetitParser') ];
				package: #'ViennaTalk-VDMPad-Core'
					with: [ spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents') ];
				package: 'ViennaTalk-Browser-Core' with: [ spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core') ];
				package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: 'ViennaTalk-LivelyWalkThrough-Core'
					with: [ spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core') ];
				package: #'ViennaTalk-Parser-Core' with: [ spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core') ];
				package: #'ViennaTalk-Parser-UI' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: 'ViennaTalk-Parser-Tests' with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI') ];
				package: #'ViennaTalk-Type-Core'.
			spec
				group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI');
				group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core');
				group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core');
				group: 'tests'
					with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests');
				group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests');
				group: 'default' with: #('full');
				group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets') ]
]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline07: spec [
	<version: '0.7-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Core'.
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline08: spec [
	<version: '0.8-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' ). ].

]

{ #category : #baselines }
ConfigurationOfViennaTalk >> baseline09: spec [
	<version: '0.9-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ].
		spec 
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'OSProcess' 'ZincHTTPComponents' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-VDMC-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-VDMC-Tests' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' ). ];
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #(#'ViennaTalk-VDMC-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ].
		spec 
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' );
			group: 'VDMC' with: #('core' #'ViennaTalk-VDMC-Core' 'ViennaTalk-Browser-Core' );
			group: 'VDMPad' with: #('core' 'ViennaTalk-Html-Core' #'ViennaTalk-VDMPad-Core' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-VDMC-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' );
			group: 'full' with: #('core' 'VDMC' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' );
			group: 'default' with: #('full' );
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' 'ViennaTalk-LivelyWalkThrough-Widgets' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Translators' ). ].

]

{ #category : #accessing }
ConfigurationOfViennaTalk >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfViennaTalk >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.14-baseline'.

]

{ #category : #accessing }
ConfigurationOfViennaTalk >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfViennaTalk >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.48'.

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version10: spec [
	<version: '1.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'tomooda'.
		spec timestamp: '8/3/2015 14:51'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.6';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.3';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.2';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version110: spec [
	<version: '1.10' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.10'.
		spec author: 'tomooda'.
		spec timestamp: '9/7/2015 11:29'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.17';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.13'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version111: spec [
	<version: '1.11' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.11'.
		spec author: 'tomooda'.
		spec timestamp: '9/12/2015 15:26'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.17';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version112: spec [
	<version: '1.12' imports: #('0.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.12'.
		spec author: 'tomooda'.
		spec timestamp: '11/18/2015 00:22'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.10';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.6';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.1';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version113: spec [
	<version: '1.13' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.13'.
		spec author: 'tomooda'.
		spec timestamp: '11/26/2015 15:08'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.13';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.9';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.8';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.1';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version114: spec [
	<version: '1.14' imports: #('0.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.14'.
		spec author: 'tomooda'.
		spec timestamp: '11/27/2015 15:28'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.14';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.9';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.9';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.1';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.3';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version115: spec [
	<version: '1.15' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.15'.
		spec author: 'tomooda'.
		spec timestamp: '11/30/2015 15:20'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.16';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.3';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.11';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.2';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.4';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version116: spec [
	<version: '1.16' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.16'.
		spec author: 'tomooda'.
		spec timestamp: '12/1/2015 10:05'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.16';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.4';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.12';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.2';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.5';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version117: spec [
	<version: '1.17' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.17'.
		spec author: 'tomooda'.
		spec timestamp: '12/2/2015 15:06'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.17';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.5';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.14';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.3';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.7';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version118: spec [
	<version: '1.18' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.18'.
		spec author: 'tomooda'.
		spec timestamp: '12/3/2015 13:47'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.18';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.17';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.4';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.8';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version119: spec [
	<version: '1.19' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.19'.
		spec author: 'tomooda'.
		spec timestamp: '12/8/2015 10:49'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.18';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.22';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.23';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.10';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.12';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version11: spec [
	<version: '1.1' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1'.
		spec author: 'tomooda'.
		spec timestamp: '8/10/2015 15:20'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.10';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.5';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.6';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.4'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version120: spec [
	<version: '1.20' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.20'.
		spec author: 'tomooda'.
		spec timestamp: '12/11/2015 09:04'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.22';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.24';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.10';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.12';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version121: spec [
	<version: '1.21' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.21'.
		spec author: 'tomooda'.
		spec timestamp: '12/16/2015 18:33'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.22';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.29';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.13';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version122: spec [
	<version: '1.22' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.22'.
		spec author: 'tomooda'.
		spec timestamp: '12/17/2015 19:37'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.22';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.17';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.15';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.30';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.13';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version123: spec [
	<version: '1.23' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.23'.
		spec author: 'tomooda'.
		spec timestamp: '12/19/2015 15:46'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.31';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.13';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version124: spec [
	<version: '1.24' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.24'.
		spec author: 'tomooda'.
		spec timestamp: '12/20/2015 17:44'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.32';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.13';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version125: spec [
	<version: '1.25' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.25'.
		spec author: 'tomooda'.
		spec timestamp: '12/22/2015 11:16'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.16';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.34';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version126: spec [
	<version: '1.26' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.26'.
		spec author: 'tomooda'.
		spec timestamp: '12/22/2015 16:46'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.11';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.16';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.35';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.12';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version127: spec [
	<version: '1.27' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.27'.
		spec author: 'tomooda'.
		spec timestamp: '12/25/2015 08:18'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.12';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.18';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.38';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version128: spec [
	<version: '1.28' imports: #('0.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.28'.
		spec author: 'tomooda'.
		spec timestamp: '12/25/2015 15:02'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.19';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.12';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.18';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.39';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version129: spec [
	<version: '1.29' imports: #('0.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.29'.
		spec author: 'tomooda'.
		spec timestamp: '12/26/2015 20:24'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.20';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.24';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.14';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.18';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.43';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version12: spec [
	<version: '1.2' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2'.
		spec author: 'tomooda'.
		spec timestamp: '8/11/2015 11:13'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.10';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.5';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.6';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version130: spec [
	<version: '1.30' imports: #('0.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.30'.
		spec author: 'tomooda'.
		spec timestamp: '12/28/2015 16:21'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.20';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.14';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.18';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version131: spec [
	<version: '1.31' imports: #('0.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.31'.
		spec author: 'tomooda'.
		spec timestamp: '1/6/2016 13:15'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.22';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.14';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.20';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.19';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.2'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version132: spec [
	<version: '1.32' imports: #('0.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.32'.
		spec author: 'tomooda'.
		spec timestamp: '1/7/2016 18:43'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.24';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.14';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.20';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.19';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.3'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version133: spec [
	<version: '1.33' imports: #('0.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.33'.
		spec author: 'tomooda'.
		spec timestamp: '1/7/2016 19:35'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.24';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.15';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.20';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.19';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.3'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version134: spec [
	<version: '1.34' imports: #('0.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.34'.
		spec author: 'tomooda'.
		spec timestamp: '1/7/2016 19:49'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.24';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.11';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.16';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.20';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.19';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.14';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.3'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version135: spec [
	<version: '1.35' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.35'.
		spec author: 'tomooda'.
		spec timestamp: '1/15/2016 13:42'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.24';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.12';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.17';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.21';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.19';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.20';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.44';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.15';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.4';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version136: spec [
	<version: '1.36' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.36'.
		spec author: 'tomooda'.
		spec timestamp: '1/22/2016 13:25'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.26';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.25';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.12';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.19';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.26';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.20';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.22';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.6';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.45';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.16';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.14';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.2';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.6';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version137: spec [
	<version: '1.37' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.37'.
		spec author: 'tomooda'.
		spec timestamp: '3/8/2016 17:10'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.28';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.30';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.12';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.19';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.27';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.21';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.66';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.26';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.6';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version138: spec [
	<version: '1.38' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.38'.
		spec author: 'tomooda'.
		spec timestamp: '3/18/2016 12:58'.
		spec 
			project: 'NeoJSON' with: '11';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.28';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.30';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.12';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.19';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.27';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.23';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.69';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.26';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.4';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.7';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version139: spec [
	<version: '1.39' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.39'.
		spec author: 'tomooda'.
		spec timestamp: '3/18/2016 13:45'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.28';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.30';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.12';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.20';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.27';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.23';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.69';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.26';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.4';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.7';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version13: spec [
	<version: '1.3' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.3'.
		spec author: 'tomooda'.
		spec timestamp: '8/11/2015 15:04'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.10';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.6';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.6';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.7'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version140: spec [
	<version: '1.40' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.40'.
		spec author: 'tomooda'.
		spec timestamp: '3/24/2016 08:44'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.29';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.34';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.20';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.27';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.23';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.74';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.26';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.11';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.5'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version141: spec [
	<version: '1.41' imports: #('0.11-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.41'.
		spec author: 'tomooda'.
		spec timestamp: '3/25/2016 18:42'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.29';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.34';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.20';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.27';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.74';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.26';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.12';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.8'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version142: spec [
	<version: '1.42' imports: #('0.12-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.42'.
		spec author: 'tomooda'.
		spec timestamp: '4/11/2016 20:21'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.34';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.31';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.9';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.90';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.12';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.1';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.1';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version143: spec [
	<version: '1.43' imports: #('0.12-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.43'.
		spec author: 'tomooda'.
		spec timestamp: '4/14/2016 19:07'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.32';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.13';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version144: spec [
	<version: '1.44' imports: #('0.12-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.44'.
		spec author: 'tomooda'.
		spec timestamp: '4/14/2016 19:11'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.32';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.13';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version145: spec [
	<version: '1.45' imports: #('0.12-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.45'.
		spec author: 'tomooda'.
		spec timestamp: '4/15/2016 12:24'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.32';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.13';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.11';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version146: spec [
	<version: '1.46' imports: #('0.14-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.46'.
		spec author: 'tomooda'.
		spec timestamp: '4/15/2016 14:56'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.18';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.13';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.11';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.32';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.23'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version147: spec [
	<version: '1.47' imports: #('0.14-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.47'.
		spec author: 'tomooda'.
		spec timestamp: '4/15/2016 15:33'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.19';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.14';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.12';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.33';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.24'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version148: spec [
	<version: '1.48' imports: #('0.14-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.48'.
		spec author: 'tomooda'.
		spec timestamp: '4/15/2016 15:47'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.31';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.35';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.21';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.10';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.93';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.19';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.27';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.3';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.14';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.12';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.3';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.3';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.33';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.25'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version14: spec [
	<version: '1.4' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.4'.
		spec author: 'tomooda'.
		spec timestamp: '8/11/2015 15:11'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.11';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.6';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.6';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.7'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version15: spec [
	<version: '1.5' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.5'.
		spec author: 'tomooda'.
		spec timestamp: '8/25/2015 14:52'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.16';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.3';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.9';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.10';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.9';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.9'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version16: spec [
	<version: '1.6' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.6'.
		spec author: 'tomooda'.
		spec timestamp: '8/26/2015 11:26'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.16';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.11';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.9';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.9'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version17: spec [
	<version: '1.7' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.7'.
		spec author: 'tomooda'.
		spec timestamp: '8/26/2015 12:58'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.16';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.13';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.9';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.9'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version18: spec [
	<version: '1.8' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.8'.
		spec author: 'tomooda'.
		spec timestamp: '8/27/2015 12:01'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.16';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.13';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.9';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.10'. ].

]

{ #category : #versions }
ConfigurationOfViennaTalk >> version19: spec [
	<version: '1.9' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.9'.
		spec author: 'tomooda'.
		spec timestamp: '9/6/2015 21:24'.
		spec 
			project: 'NeoJSON' with: '10';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.10'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.17';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.4';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.4';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.8';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.2';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.10';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.14';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.12'. ].

]
