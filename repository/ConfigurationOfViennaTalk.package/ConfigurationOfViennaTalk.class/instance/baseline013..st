baselines
baseline013: spec
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