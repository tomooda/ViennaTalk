baselines
baseline03: spec
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
