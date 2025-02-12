Class {
	#name : 'ViennaHiDeStorage',
	#superclass : 'HiDeStorage',
	#classInstVars : [
		'current'
	],
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'sole instance' }
ViennaHiDeStorage class >> current [

	^ current ifNil: [
		  current := self new
			             basepath: FileLocator viennaTalkDocumentDirectory;
			             yourself ]
]

{ #category : 'class access' }
ViennaHiDeStorage >> payloadClassFor: aHiDeMetadata [

	^ ViennaEpiLog classFor: (aHiDeMetadata at: 'class')
]
