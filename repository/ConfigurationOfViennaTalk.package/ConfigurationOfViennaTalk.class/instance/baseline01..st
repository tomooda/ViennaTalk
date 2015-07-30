baselines
baseline01: spec
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
