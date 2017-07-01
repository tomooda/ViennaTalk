versions
version156: spec
	<version: '1.56' imports: #('0.20-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.56'.
		spec author: 'tomooda'.
		spec timestamp: '7/1/2017 16:09'.
		spec 
			project: 'NeoJSON' with: '2-baseline';
			project: 'OSSubprocess' with: '0.2.4';
			project: 'PetitParser' with: '1.14';
			project: 'ZincHTTPComponents' with: '2.6.2'.
		spec 
			package: 'ViennaTalk-Animation-Core' with: 'ViennaTalk-Animation-Core-tomooda.3';
			package: 'ViennaTalk-Animation-Tests' with: 'ViennaTalk-Animation-Tests-tomooda.2';
			package: 'ViennaTalk-Animation-Transpiler' with: 'ViennaTalk-Animation-Transpiler-tomooda.4';
			package: 'ViennaTalk-Browser-Core' with: 'ViennaTalk-Browser-Core-tomooda.46';
			package: #'ViennaTalk-Engine-Core' with: 'ViennaTalk-Engine-Core-tomooda.39';
			package: #'ViennaTalk-Engine-Tests' with: 'ViennaTalk-Engine-Tests-tomooda.6';
			package: 'ViennaTalk-Html-Core' with: 'ViennaTalk-Html-Core-tomooda.4';
			package: #'ViennaTalk-Launcher-Core' with: 'ViennaTalk-Launcher-Core-tomooda.15';
			package: 'ViennaTalk-LivelyWalkThrough-Core' with: 'ViennaTalk-LivelyWalkThrough-Core-tomooda.33';
			package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: 'ViennaTalk-LivelyWalkThrough-Widgets-tomooda.25';
			package: #'ViennaTalk-Parser-Core' with: 'ViennaTalk-Parser-Core-tomooda.111';
			package: #'ViennaTalk-Parser-Formatters' with: 'ViennaTalk-Parser-Formatters-tomooda.15';
			package: #'ViennaTalk-Parser-Highlighters' with: 'ViennaTalk-Parser-Highlighters-tomooda.5';
			package: 'ViennaTalk-Parser-Tests' with: 'ViennaTalk-Parser-Tests-tomooda.39';
			package: #'ViennaTalk-Parser-UI' with: 'ViennaTalk-Parser-UI-tomooda.25';
			package: #'ViennaTalk-Transpiler-Core' with: 'ViennaTalk-Transpiler-Core-tomooda.2';
			package: #'ViennaTalk-Transpiler-Debugger' with: 'ViennaTalk-Transpiler-Debugger-tomooda.1';
			package: #'ViennaTalk-Transpiler-Test' with: 'ViennaTalk-Transpiler-Test-tomooda.1';
			package: #'ViennaTalk-Type-Core' with: 'ViennaTalk-Type-Core-tomooda.16';
			package: #'ViennaTalk-Type-Tests' with: 'ViennaTalk-Type-Tests-tomooda.7';
			package: #'ViennaTalk-VDMPad-Core' with: 'ViennaTalk-VDMPad-Core-tomooda.29';
			package: #'ViennaTalk-Value-Core' with: 'ViennaTalk-Value-Core-tomooda.52';
			package: #'ViennaTalk-Value-Tests' with: 'ViennaTalk-Value-Tests-tomooda.16';
			package: #'ViennaTalk-WeblyWalkThrough-Server' with: 'ViennaTalk-WeblyWalkThrough-Server-tomooda.16';
			package: #'ViennaTalk-WeblyWalkThrough-Translators' with: 'ViennaTalk-WeblyWalkThrough-Translators-tomooda.5'. ].
