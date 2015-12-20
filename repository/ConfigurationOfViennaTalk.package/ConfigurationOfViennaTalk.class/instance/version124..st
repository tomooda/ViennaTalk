versions
version124: spec
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
