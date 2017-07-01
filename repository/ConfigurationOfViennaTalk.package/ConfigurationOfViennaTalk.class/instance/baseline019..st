baselines
baseline019: spec
	<version: '0.19-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/tomooda/ViennaTalk/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'OSSubprocess' with: [
				spec
					className: #ConfigurationOfOSSubprocess;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main/' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40/main';
					repository: 'http://smalltalkhub.com/mc/Pharo/Pharo40Inbox/main' ].
		spec 
			package: 'ViennaTalk-Animation-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core' ). ];
			package: 'ViennaTalk-Animation-Tests' with: [
				spec requires: #('ViennaTalk-Animation-Core' ). ];
			package: 'ViennaTalk-Animation-Transpiler' with: [
				spec requires: #('ViennaTalk-Animation-Core' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Transpiler-Debugger' #'ViennaTalk-Transpiler-Runtime' ). ];
			package: 'ViennaTalk-Browser-Core' with: [
				spec requires: #('ViennaTalk-Animation-Core' #'ViennaTalk-Value-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' ). ];
			package: #'ViennaTalk-Engine-Core' with: [
				spec requires: #('NeoJSON' 'ZincHTTPComponents' 'OSSubprocess' ). ];
			package: #'ViennaTalk-Engine-Tests' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' ). ];
			package: 'ViennaTalk-Html-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: #'ViennaTalk-Launcher-Core';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
				spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' 'ViennaTalk-Browser-Core' 'ViennaTalk-Animation-Core' ). ];
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Parser-Core' with: [
				spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-Parser-Formatters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Parser-Highlighters' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: 'ViennaTalk-Parser-Tests' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI' ). ];
			package: #'ViennaTalk-Parser-UI' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' ). ];
			package: #'ViennaTalk-Transpiler-Core' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Transpiler-Runtime' #'ViennaTalk-Transpiler-Debugger' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Transpiler-Debugger' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' #'ViennaTalk-Transpiler-Runtime' ). ];
			package: #'ViennaTalk-Transpiler-Runtime' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Transpiler-Test' with: [
				spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Type-Core' #'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-Type-Core';
			package: #'ViennaTalk-Type-Tests' with: [
				spec requires: #(#'ViennaTalk-Type-Core' ). ];
			package: #'ViennaTalk-VDMPad-Core' with: [
				spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' 'ViennaTalk-Html-Core' ). ];
			package: #'ViennaTalk-Value-Core';
			package: #'ViennaTalk-Value-Tests' with: [
				spec requires: #(#'ViennaTalk-Value-Core' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: [
				spec requires: #('ViennaTalk-Animation-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-WeblyWalkThrough-Translators' ). ];
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [
				spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser' 'NeoJSON' ). ].
		spec 
			group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core' );
			group: 'Transpiler' with: #('ViennaTalk-Animation-Transpiler' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Transpiler-Debugger' #'ViennaTalk-Transpiler-Runtime' );
			group: 'VDMPad' with: #(#'ViennaTalk-VDMPad-Core' );
			group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Server' );
			group: 'core' with: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' );
			group: 'default' with: #('full' );
			group: 'full' with: #('core' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' 'Transpiler' );
			group: 'tests' with: #(#'ViennaTalk-Engine-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' 'ViennaTalk-Animation-Tests' ). ].
