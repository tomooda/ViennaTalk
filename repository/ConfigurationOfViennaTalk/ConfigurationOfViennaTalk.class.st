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

{ #category : #accessing }
ConfigurationOfViennaTalk >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfViennaTalk >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.2-baseline'.

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

	spec for: #'common' version: '1.2'.

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
