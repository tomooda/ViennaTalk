versions
version136: spec
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
