Class {
	#name : #BaselineOfViennaTalk,
	#superclass : #BaselineOf,
	#category : #BaselineOfViennaTalk
}

{ #category : #baselines }
BaselineOfViennaTalk >> baseline: spec [

	<baseline>
	spec
		for: #common do: [ 
			spec blessing: #baseline.
			spec
				baseline: 'NeoJSON'
				with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
				baseline: 'PetitParser2'
				with: [ spec repository: 'github://kursjan/petitparser2:master' ];
				baseline: 'ZincHTTPComponents'
				with: [ spec repository: 'github://svenvc/zinc/repository' ].
			spec
				package: 'ViennaTalk-Animation-Core' with: [ spec requires:
							#( 'ViennaTalk-Engine-Core' 'ViennaTalk-Value-Core' )
					 ];
				package: 'ViennaTalk-Animation-Tests'
				with: [ spec requires: #( 'ViennaTalk-Animation-Core' ) ];
				package: 'ViennaTalk-Animation-Transpiler'
				with: [ spec requires:
							#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Parser-Core'
							   'ViennaTalk-Transpiler-Core' 'ViennaTalk-Transpiler-Debugger' )
					 ];
				package: 'ViennaTalk-Browser-Core' with: [ spec requires:
							#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Animation-Transpiler'
							   'ViennaTalk-Launcher-Core' 'ViennaTalk-Parser-Core'
							   'ViennaTalk-Parser-Formatters'
							   'ViennaTalk-Parser-Highlighters'
							   'ViennaTalk-Refactoring-Core' 'ViennaTalk-Transpiler-Core'
							   'ViennaTalk-Value-Core' )
					 ];
				package: #'ViennaTalk-Engine-Core'
				with: [ spec requires: #( 'NeoJSON' 'ZincHTTPComponents' ) ];
				for: #Unix do: [ 
					spec
						baseline: 'OSSubprocess'
						with: [ 
							spec repository: 'github://marianopeck/OSSubprocess/repository' ];
						package: #'ViennaTalk-Engine-Core'
						with: [ spec requires: #( 'OSSubprocess' ) ] ];
				for: #Windows do: [ "spec
						baseline: 'ProcessWrapper'
							with: [ spec repository: 'github://hernanmd/ProcessWrapper' ];
						package: #'ViennaTalk-Engine-OSSubprocess'
							with: [ spec requires: #('ProcessWrapper') ];
						package: #'ViennaTalk-Engine-Core'
							with: [ spec requires: #('ViennaTalk-Engine-OSSubprocess')" 
				spec package: 'ViennaTalk-Engine-Core' ] ];
		package: #'ViennaTalk-Engine-Tests'
		with: [ spec requires: #( 'ViennaTalk-Engine-Core' ) ];
		package: 'ViennaTalk-Html-Core'
		with: [ spec requires: #( 'PetitParser2' ) ];
		package: 'ViennaTalk-Launcher-Core';
		package: 'ViennaTalk-LivelyWalkThrough-Core' with: [ 
		spec requires:
			#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Animation-Transpiler'
			   'ViennaTalk-Browser-Core' 'ViennaTalk-Launcher-Core'
			   'PetitParser2' ) ];
		package: #'ViennaTalk-Parser-Core'
		with: [ spec requires: #( 'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-Parser-Formatters'
		with: [ spec requires: #( 'ViennaTalk-Parser-Core' ) ];
		package: #'ViennaTalk-Parser-Highlighters'
		with: [ spec requires: #( 'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Parser-Tests'
		with: [ 
		spec requires: #( 'ViennaTalk-Parser-Core' 'ViennaTalk-Parser-UI' ) ];
		package: #'ViennaTalk-Parser-UI'
		with: [ spec requires: #( 'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Refactoring-Core'
		with: [ spec requires: #( 'ViennaTalk-Parser-Core' ) ];
		package: #'ViennaTalk-Transpiler-Core' with: [ 
		spec requires: #( 'ViennaTalk-Parser-Core' 'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-Transpiler-Debugger' with: [ 
		spec requires:
			#( 'ViennaTalk-Parser-Core' 'ViennaTalk-Parser-Formatters'
			   'ViennaTalk-Parser-Highlighters'
			   'ViennaTalk-Transpiler-Core' ) ];
		package: #'ViennaTalk-Transpiler-Test' with: [ 
		spec requires:
			#( 'ViennaTalk-Parser-Core' #'ViennaTalk-Transpiler-Core'
			   'ViennaTalk-Type-Core' #'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-Type-Core'
		with: [ spec requires: #( 'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-Type-Tests'
		with: [ 
		spec requires: #( 'ViennaTalk-Type-Core' 'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-VDMPad-Core' with: [ 
		spec requires:
			#( 'ViennaTalk-Engine-Core' 'NeoJSON' 'ZincHTTPComponents'
			   'ViennaTalk-Html-Core' 'ViennaTalk-Parser-Core' ) ];
		package: #'ViennaTalk-Value-Core';
		package: #'ViennaTalk-Value-Tests'
		with: [ spec requires: #( 'ViennaTalk-Value-Core' ) ];
		package: #'ViennaTalk-WeblyWalkThrough-Server' with: [ 
		spec requires:
			#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Browser-Core'
			   'ViennaTalk-Launcher-Core' 'ViennaTalk-WeblyWalkThrough-Translators' ) ];
		package: #'ViennaTalk-WeblyWalkThrough-Translators' with: [ 
		spec requires: #( 'ViennaTalk-Parser-Core' 'ViennaTalk-Value-Core'
			   'PetitParser2' 'NeoJSON' ) ].
	spec
		group: 'LivelyWalkThrough'
		with: #( 'ViennaTalk-LivelyWalkThrough-Core' );
		group: 'Transpiler'
		with:
			#( 'ViennaTalk-Animation-Transpiler'
			   #'ViennaTalk-Transpiler-Core' #'ViennaTalk-Transpiler-Debugger' );
		group: 'VDMPad' with: #( #'ViennaTalk-VDMPad-Core' );
		group: 'WeblyWalkThrough'
		with: #( #'ViennaTalk-WeblyWalkThrough-Server' );
		group: 'core'
		with: #( 'ViennaTalk-Engine-Core' 'ViennaTalk-Parser-Core'
			   'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core'
			   'ViennaTalk-Parser-Formatters' #'ViennaTalk-Parser-Highlighters' );
		group: 'default' with: #( 'full' );
		group: 'full'
		with:
			#( 'core' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough'
			   'Transpiler' );
		group: 'tests'
		with: #( #'ViennaTalk-Engine-Tests' #'ViennaTalk-Value-Tests'
			   'ViennaTalk-Parser-Tests' #'ViennaTalk-Type-Tests'
			   'ViennaTalk-Animation-Tests' #'ViennaTalk-Transpiler-Test' )
]

{ #category : #accessing }
BaselineOfViennaTalk >> customProjectAttributes [
	Smalltalk os isWindows
		ifTrue: [ ^ #(#Windows) ].
	(Smalltalk os isUnix or: [ Smalltalk os isMacOSX ])
		ifTrue: [ ^ #(#Unix) ]
]
