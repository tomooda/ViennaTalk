versions
version140: spec
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
