Class {
	#name : 'ViennaFeedWorkerPoolForVDMPad',
	#superclass : 'ViennaFeedWorkerPool',
	#category : 'ViennaTalk-VDMPad-Core-Feed',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Feed'
}

{ #category : 'accessing' }
ViennaFeedWorkerPoolForVDMPad class >> commandName [

	^ 'vdmpad-worker'
]

{ #category : 'accessing' }
ViennaFeedWorkerPoolForVDMPad class >> description [

	^ 'A worker process for VDMPad'
]

{ #category : 'accessing' }
ViennaFeedWorkerPoolForVDMPad class >> newWorkers: anInteger [

	anInteger timesRepeat: [ self newWorker ]
]

{ #category : 'accessing' }
ViennaFeedWorkerPoolForVDMPad class >> poolDirectory [

	^ FileLocator viennaTalkDirectory / 'VDMPad-pool'
]

{ #category : 'system startup' }
ViennaFeedWorkerPoolForVDMPad class >> registerShutdown [

	SessionManager default registerUserClassNamed: self name
]

{ #category : 'system startup' }
ViennaFeedWorkerPoolForVDMPad class >> shutDown: quitting [

	quitting ifTrue: [ self close ]
]

{ #category : 'system startup' }
ViennaFeedWorkerPoolForVDMPad class >> unregisterShutdown [

	<script>
	SessionManager default unregisterHandler: self name ifAbsent: [ ]
]

{ #category : 'accessing' }
ViennaFeedWorkerPoolForVDMPad class >> worker [

	<commandline>
	^ self commandSpec
]

{ #category : 'defaults' }
ViennaFeedWorkerPoolForVDMPad >> defaultEngine [

	^ ViennaEngineForVDMPad default
]
