Class {
	#name : 'BaselineOfViennaTalk',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfViennaTalk',
	#package : 'BaselineOfViennaTalk'
}

{ #category : 'accessing' }
BaselineOfViennaTalk class >> codename [

	^ 'Nowhere'
]

{ #category : 'utilities' }
BaselineOfViennaTalk class >> ensureIcebergRepository [

	^ IceRepository repositories
		  detect: [ :repo | repo name = 'ViennaTalk' ]
		  ifNone: [
			  | repo |
			  UIManager default
				  informUser:
				  'Cloning repository from the official ViennaTalk repository'
				  during: [
					  repo := IceRepositoryCreator new
						          repository: nil;
						          remote:
							          (IceGitRemote url:
									           'https://github.com/tomooda/ViennaTalk.git');
						          location:
							          FileLocator localDirectory / 'iceberg' / 'tomooda'
							          / 'ViennaTalk';
						          createRepository ].
			  repo
				  register;
				  yourself ]
]

{ #category : 'testing' }
BaselineOfViennaTalk class >> isDev [

	^ self codename = 'Nowhere'
]

{ #category : 'utilities' }
BaselineOfViennaTalk class >> updateFromOfficialRepository [

	<script: 'BaselineOfViennaTalk updateFromOfficialRepository'>
	| repository branchName |
	repository := self ensureIcebergRepository.
	branchName := self isDev
		              ifTrue: [ 'dev' ]
		              ifFalse: [ 'main' ].
	repository
		branchNamed: branchName
		ifPresent: [ :branch |
			[
			branch
				setUpstreamIfMissing: (repository remoteNamed: 'origin');
				pull ]
				on: IceExperimentalFeature
				do: [ :ex | ex resume ] ]
		ifAbsent: [
		(repository remoteBranchNamed: 'origin/' , branchName) checkout ].
	[ (repository packageNamed: 'BaselineOfViennaTalk') reload ]
		on: MCMergeOrLoadWarning
		do: [ :ex | ex load ].
	Cursor wait showWhile: [
		| maxCount count |
		maxCount := 5.
		count := 0.
		[
		[
		Metacello new
			repository: 'gitlocal://' , (repository location / 'src') fullName;
			baseline: 'ViennaTalk';
			onConflictUseIncoming;
			onWarningLog;
			load ]
			on: IceExperimentalFeature
			do: [ :ex | ex resume ] ]
			on: Error
			do: [ :ex |
				(count := count + 1) < maxCount
					ifTrue: [
						2 seconds wait.
						ex retry ]
					ifFalse: [ UIManager default alert: 'Failed to update' ] ] ].
	Smalltalk snapshot: true andQuit: false
]

{ #category : 'baselines' }
BaselineOfViennaTalk >> baseline: spec [

	<baseline>
	spec
		for: #common do: [
				spec blessing: #baseline.
				spec
					baseline: 'Phleeter'
					with: [ spec repository: 'github://tomooda/Phleeter:main/src' ];
					baseline: 'HiDeHo'
					with: [ spec repository: 'github://tomooda/HiDeHo:main/src' ];
					baseline: 'Micromaid'
					with: [ spec repository: 'github://tomooda/Micromaid:main/src' ];
					baseline: 'FRAM'
					with: [ spec repository: 'github://tomooda/FRAM:main/src' ];
					baseline: 'Pharo9UTF8Path'
					with: [
						spec repository: 'github://tomooda/Pharo9UTF8Path:main/src' ];
					baseline: 'NeoJSON'
					with: [ spec repository: 'github://svenvc/NeoJSON/repository' ];
					baseline: 'PetitParser2'
					with: [ spec repository: 'github://kursjan/petitparser2:master' ].
				spec
					package: 'ViennaTalk-AST-Core'
					with: [ spec requires: #( 'ViennaTalk-Type-Core' ) ];
					package: 'ViennaTalk-AST-Tests' with: [
							spec requires:
									#( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core'
									   'ViennaTalk-Type-Core' ) ];
					package: 'ViennaTalk-Application'
					with: [ spec requires: #( 'Phleeter' ) ];
					package: 'ViennaTalk-Animation-Core' with: [
						spec requires:
								#( 'ViennaTalk-Engine-Core' 'ViennaTalk-Value-Core' ) ];
					package: 'ViennaTalk-Animation-Tests'
					with: [ spec requires: #( 'ViennaTalk-Animation-Core' ) ];
					package: 'ViennaTalk-Animation-Transpiler' with: [
							spec requires:
									#( 'ViennaTalk-AST-Core' 'ViennaTalk-Animation-Core'
									   'ViennaTalk-Parser-Core' 'ViennaTalk-Profiler-Core'
									   'ViennaTalk-Transpiler-Core' 'ViennaTalk-Type-Core'
									   'ViennaTalk-Value-Core' ) ];
					package: 'ViennaTalk-Engine-Transpiler' with: [
							spec requires:
									#( 'ViennaTalk-Animation-Transpiler'
									   'ViennaTalk-Engine-Core' ) ];
					package: 'ViennaTalk-Browser-Core' with: [
							spec requires:
									#( 'ViennaTalk-AST-Core' 'ViennaTalk-Animation-Core'
									   'ViennaTalk-Animation-Transpiler'
									   'ViennaTalk-ExecutionTrace-Core'
									   'ViennaTalk-FRAM-Core' 'ViennaTalk-Launcher-Core'
									   'ViennaTalk-Mutation-Core' 'ViennaTalk-Parser-Core'
									   'ViennaTalk-Parser-Formatters'
									   'ViennaTalk-Parser-Highlighters'
									   'ViennaTalk-Refactoring-Core'
									   'ViennaTalk-Slicing-Core' 'ViennaTalk-Transpiler-Core'
									   'ViennaTalk-Type-Core' 'ViennaTalk-Value-Core'
									   'HiDeHo' ) ];
					package: 'ViennaTalk-Engine-Core'
					with: [ spec requires: #( 'NeoJSON' ) ];
					for: #Unix do: [
							spec
								baseline: 'OSSubprocess'
								with: [
									spec repository:
											'github://marianopeck/OSSubprocess/repository' ];
								package: 'ViennaTalk-Engine-Core'
								with: [ spec requires: #( 'OSSubprocess' ) ] ];
					for: #Windows do: [ spec package: 'ViennaTalk-Engine-Core' ] ];
		package: 'ViennaTalk-Engine-Tests'
		with: [ spec requires: #( 'ViennaTalk-Engine-Core' ) ];
		package: 'ViennaTalk-ExecutionTrace-Core' with: [
			spec requires:
				#( 'Micromaid' 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Transpiler-Core' 'ViennaTalk-Type-Core'
				   'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-ExecutionTrace-Tests'
		with: [ spec requires: #( 'ViennaTalk-ExecutionTrace-Core' ) ];
		package: 'ViennaTalk-FRAM-Core' with: [
			spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Value-Core' 'FRAM' ) ];
		package: 'ViennaTalk-FRAM-Tests'
		with: [
		spec requires: #( 'ViennaTalk-FRAM-Core' 'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Html-Core'
		with: [ spec requires: #( 'PetitParser2' ) ];
		package: 'ViennaTalk-Launcher-Core' with: [
		spec requires:
			#( 'ViennaTalk-Browser-Core' 'ViennaTalk-VDMPad-Core' ) ];
		package: 'ViennaTalk-LivelyWalkThrough-Core' with: [
			spec requires:
				#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Animation-Transpiler'
				   'ViennaTalk-Browser-Core' 'ViennaTalk-Launcher-Core'
				   'ViennaTalk-Value-Core' 'PetitParser2' ) ];
		package: 'ViennaTalk-Mutation-Core'
		with: [
		spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Type-Core' ) ];
		package: 'ViennaTalk-Mutation-Tests'
		with: [ spec requires: #( 'ViennaTalk-Mutation-Core' ) ];
		package: 'ViennaTalk-Parser-Core' with: [
			spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Value-Core'
				   'PetitParser2' ) ];
		package: 'ViennaTalk-Parser-Formatters'
		with: [
		spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Parser-Highlighters' with: [
			spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Parser-Formatters' 'ViennaTalk-Transpiler-Core' ) ];
		package: 'ViennaTalk-Parser-Tests' with: [
			spec requires:
				#( 'ViennaTalk-Parser-Core' 'ViennaTalk-Parser-Formatters' ) ];
		package: 'ViennaTalk-Parser-UI' with: [
			spec requires:
				#( 'ViennaTalk-Launcher-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Transpiler-Core' ) ];
		package: 'ViennaTalk-Profiler-Core' with: [ spec requires: #(  ) ];
		package: 'ViennaTalk-Profiler-Tests'
		with: [ spec requires: #( 'ViennaTalk-Profiler-Core' ) ];
		package: 'ViennaTalk-Refactoring-Core'
		with: [
		spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Refactoring-Tests' with: [
			spec requires:
				#( 'ViennaTalk-AST-Core' 'ViennaTalk-Refactoring-Core' ) ];
		package: 'ViennaTalk-Slicing-Core'
		with: [ spec requires: #( 'ViennaTalk-AST-Core' ) ];
		package: 'ViennaTalk-Slicing-Tests' with: [
			spec requires: #( 'ViennaTalk-Slicing-Core'
				   'ViennaTalk-AST-Core' 'ViennaTalk-AST-Tests' ) ];
		package: 'ViennaTalk-Transpiler-Core' with: [
			spec requires: #( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-Transpiler-Debugger' with: [
			spec requires:
				#( 'ViennaTalk-AST-Core' 'ViennaTalk-Parser-Formatters'
				   'ViennaTalk-Parser-Highlighters'
				   'ViennaTalk-Slicing-Core' 'ViennaTalk-Transpiler-Core' ) ];
		package: 'ViennaTalk-Transpiler-Tests' with: [
			spec requires:
				#( 'ViennaTalk-Parser-Core' 'ViennaTalk-Transpiler-Core'
				   'ViennaTalk-Type-Core' 'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-Type-Core'
		with: [ spec requires: #( 'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-Type-Tests'
		with: [
		spec requires: #( 'ViennaTalk-Type-Core' 'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-VDMPad-Core' with: [
			spec requires:
				#( 'ViennaTalk-Engine-Core' 'NeoJSON' 'ViennaTalk-Html-Core'
				   'ViennaTalk-Parser-Core' ) ];
		package: 'ViennaTalk-Value-Core';
		package: 'ViennaTalk-Value-Tests'
		with: [ spec requires: #( 'ViennaTalk-Value-Core' ) ];
		package: 'ViennaTalk-WeblyWalkThrough-Server' with: [
			spec requires:
				#( 'ViennaTalk-Animation-Core' 'ViennaTalk-Browser-Core'
				   'ViennaTalk-Launcher-Core' 'ViennaTalk-Parser-Core'
				   'ViennaTalk-Value-Core' 'ViennaTalk-WeblyWalkThrough-Translators' ) ];
		package: 'ViennaTalk-WeblyWalkThrough-Translators' with: [
			spec requires: #( 'ViennaTalk-Parser-Core' 'ViennaTalk-Value-Core'
				   'PetitParser2' 'NeoJSON' ) ];
		yourself.

	spec
		group: 'Application' with: #( 'ViennaTalk-Application' );
		group: 'ViennaFRAM' with: #( 'ViennaTalk-FRAM-Core' );
		group: 'LivelyWalkThrough'
		with: #( 'ViennaTalk-LivelyWalkThrough-Core' );
		group: 'Transpiler'
		with:
			#( 'ViennaTalk-Animation-Transpiler'
			   'ViennaTalk-Engine-Transpiler' 'ViennaTalk-Transpiler-Core'
			   'ViennaTalk-Transpiler-Debugger'
			   'ViennaTalk-ExecutionTrace-Core'
			   'ViennaTalk-Profiler-Core' );
		group: 'VDMPad' with: #( 'ViennaTalk-VDMPad-Core' );
		group: 'WeblyWalkThrough'
		with: #( 'ViennaTalk-WeblyWalkThrough-Server' );
		group: 'core'
		with: #( 'ViennaTalk-Engine-Core' 'ViennaTalk-Parser-Core'
			   'ViennaTalk-Launcher-Core' 'ViennaTalk-Browser-Core'
			   'ViennaTalk-Parser-Formatters' 'ViennaTalk-Parser-Highlighters'
			   'ViennaTalk-ExecutionTrace-Core'
			   'ViennaTalk-Slicing-Core' 'ViennaTalk-Mutation-Core' );
		group: 'default' with: #( 'full' );
		group: 'full'
		with:
			#( 'core' 'VDMPad' 'LivelyWalkThrough' 'tests' 'WeblyWalkThrough'
			   'Transpiler' 'ViennaFRAM' 'Application' );
		group: 'tests'
		with: #( 'ViennaTalk-Engine-Tests' 'ViennaTalk-Value-Tests'
			   'ViennaTalk-Parser-Tests' 'ViennaTalk-Type-Tests'
			   'ViennaTalk-Animation-Tests' 'ViennaTalk-Transpiler-Tests'
			   'ViennaTalk-FRAM-Tests' 'ViennaTalk-Slicing-Tests'
			   'ViennaTalk-Refactoring-Tests' 'ViennaTalk-AST-Tests'
			   'ViennaTalk-ExecutionTrace-Tests'
			   'ViennaTalk-Profiler-Tests' 'ViennaTalk-Mutation-Tests' )
]

{ #category : 'accessing' }
BaselineOfViennaTalk >> customProjectAttributes [
	Smalltalk os isWindows
		ifTrue: [ ^ #(#Windows) ].
	(Smalltalk os isUnix or: [ Smalltalk os isMacOSX ])
		ifTrue: [ ^ #(#Unix) ]
]
