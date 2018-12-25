Class {
	#name : #BaselineOfViennaTalk,
	#superclass : #BaselineOf,
	#category : 'BaselineOfViennaTalk'
}

{ #category : #baselines }
BaselineOfViennaTalk >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
				baseline: 'OSSubprocess' with: [ spec repository: 'github://marianopeck/OSSubprocess/repository' ];
				configuration: 'ProcessWrapper'
					with: [ spec
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main' ];
				baseline: 'PetitParser2' with: [ spec repository: 'github://kursjan/petitparser2:master' ];
				project: 'ZincHTTPComponents'
					with: [ spec
						className: #ConfigurationOfZincHTTPComponents;
						versionString: #stable;
						repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].
			spec
				package: 'ViennaTalk-Animation-Core' with: [ spec requires: #(#'ViennaTalk-Engine-Core' #'ViennaTalk-Value-Core') ];
				package: 'ViennaTalk-Animation-Tests' with: [ spec requires: #('ViennaTalk-Animation-Core') ];
				package: 'ViennaTalk-Animation-Transpiler'
					with: [ spec requires: #('ViennaTalk-Animation-Core' 'ViennaTalk-Transpiler-Core' 'ViennaTalk-Transpiler-Debugger') ];
				package: 'ViennaTalk-Browser-Core'
					with: [ spec
						requires: #('ViennaTalk-Animation-Core' #'ViennaTalk-Value-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters') ];
				for: #Unix
					do: [ spec package: #'ViennaTalk-Engine-Core' with: [ spec requires: #('NeoJSON' 'ZincHTTPComponents' 'OSSubprocess') ] ];
				for: #Windows
					do:
						[ spec package: #'ViennaTalk-Engine-Core' with: [ spec requires: #('NeoJSON' 'ZincHTTPComponents' 'ViennaTalk-Engine-OSSubprocess') ] ];
				package: #'ViennaTalk-Engine-OSSubprocess' with: [ spec requires: #('ProcessWrapper') ];
				package: #'ViennaTalk-Engine-Tests' with: [ spec requires: #(#'ViennaTalk-Engine-Core') ];
				package: 'ViennaTalk-Html-Core' with: [ spec requires: #('PetitParser2') ];
				package: #'ViennaTalk-Launcher-Core';
				package: 'ViennaTalk-LivelyWalkThrough-Core'
					with: [ spec requires: #('ViennaTalk-LivelyWalkThrough-Widgets' 'ViennaTalk-Browser-Core' 'ViennaTalk-Animation-Core') ];
				package: 'ViennaTalk-LivelyWalkThrough-Widgets' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-Parser-Core' with: [ spec requires: #(#'ViennaTalk-Value-Core' #'ViennaTalk-Type-Core') ];
				package: #'ViennaTalk-Parser-Formatters' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: #'ViennaTalk-Parser-Highlighters' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: 'ViennaTalk-Parser-Tests' with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-UI') ];
				package: #'ViennaTalk-Parser-UI' with: [ spec requires: #(#'ViennaTalk-Parser-Core') ];
				package: #'ViennaTalk-Transpiler-Core' with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-Transpiler-Debugger'
					with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters') ];
				package: #'ViennaTalk-Transpiler-Test'
					with: [ spec requires: #(#'ViennaTalk-Parser-Core' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Type-Core' #'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-Type-Core';
				package: #'ViennaTalk-Type-Tests' with: [ spec requires: #(#'ViennaTalk-Type-Core') ];
				package: #'ViennaTalk-VDMPad-Core'
					with: [ spec requires: #(#'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents' 'ViennaTalk-Html-Core') ];
				package: #'ViennaTalk-Value-Core';
				package: #'ViennaTalk-Value-Tests' with: [ spec requires: #(#'ViennaTalk-Value-Core') ];
				package: #'ViennaTalk-WeblyWalkThrough-Server'
					with: [ spec requires: #('ViennaTalk-Animation-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-WeblyWalkThrough-Translators') ];
				package: #'ViennaTalk-WeblyWalkThrough-Translators'
					with: [ spec requires: #(#'ViennaTalk-Value-Core' 'PetitParser2' 'NeoJSON') ].
			spec
				group: 'LivelyWalkThrough' with: #('ViennaTalk-LivelyWalkThrough-Core');
				group: 'Transpiler' with: #('ViennaTalk-Animation-Transpiler' #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Transpiler-Debugger');
				group: 'VDMPad' with: #(#'ViennaTalk-VDMPad-Core');
				group: 'WeblyWalkThrough' with: #(#'ViennaTalk-WeblyWalkThrough-Server');
				group: 'core'
					with:
					#(#'ViennaTalk-Engine-Core' #'ViennaTalk-Parser-Core' #'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core' #'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters');
				group: 'default' with: #('full');
				group: 'full' with: #('core' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough' 'Transpiler');
				group: 'tests'
					with:
					#(#'ViennaTalk-Engine-Tests' #'ViennaTalk-Value-Tests' 'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests' 'ViennaTalk-Animation-Tests' #'ViennaTalk-Transpiler-Test') ]
]

{ #category : #accessing }
BaselineOfViennaTalk >> customProjectAttributes [
	(Smalltalk os isUnix or: [ Smalltalk os isMacOSX ])
		ifTrue: [ ^ #(#Unix) ].
	Smalltalk os isWindows
		ifTrue: [ ^ #(#Windows) ]
]
