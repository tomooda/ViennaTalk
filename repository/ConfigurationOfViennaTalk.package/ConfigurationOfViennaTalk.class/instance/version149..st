versions
version149: spec
	<version: '1.49' imports: #('0.14-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.49'.
		spec author: 'tomooda'.
		spec timestamp: '7/29/2016 15:39'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'OSProcess' with: '4.6.4';
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.33';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.39';
			package: #'ViennaTalk-VDMC-Core' with: 'ViennaTalk-VDMC-Core-tomooda.9';
			package: #'ViennaTalk-VDMC-Tests' with: 'ViennaTalk-VDMC-Tests-tomooda.2';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.13';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.25';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.24';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.12';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.99';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.20';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.29';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.14';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.12';
			package: #'ViennaTalk-Parser-Code Generators' with: 'ViennaTalk-Parser-Code Generators-tomooda.16';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.7';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.1';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.34';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.25'. ].
