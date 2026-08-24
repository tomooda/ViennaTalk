Class {
	#name : 'MicViennaBlock',
	#superclass : 'MicScriptBlock',
	#instVars : [
		'vdmParser',
		'presenter',
		'resultString',
		'errorString'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'testing' }
MicViennaBlock class >> isAbstract [

	^ self == MicViennaBlock
]

{ #category : 'accessing' }
MicViennaBlock class >> tag [

	^ nil
]

{ #category : 'accessing' }
MicViennaBlock >> bodyNode [

	| bodyNode |
	bodyNode := self vdmParser parse: self body asString trim.
	^ bodyNode isPetit2Success
		  ifTrue: [ bodyNode ]
		  ifFalse: [
				  self syntaxError.
				  bodyNode ]
]

{ #category : 'private' }
MicViennaBlock >> createVdmParser [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MicViennaBlock >> errorString [

	^ errorString
]

{ #category : 'accessing' }
MicViennaBlock >> errorString: aString [

	errorString := errorString ifNil: [ aString ] ifNotNil: [ errorString , ', ' , aString ]
]

{ #category : 'executing' }
MicViennaBlock >> flushResultString [

	resultString := nil
]

{ #category : 'accessing' }
MicViennaBlock >> moduleName [

	^ arguments at: #module ifAbsent: [ nil ]
]

{ #category : 'error messaging' }
MicViennaBlock >> noSpecificationError [

	self errorString: 'Specification is not available'.
	^ nil
]

{ #category : 'accessing' }
MicViennaBlock >> receiver [

	^ presenter ifNotNil: [
			  self specification
				  ifNotNil: [ :spec |
						  self moduleName
							  ifNotNil: [ :moduleName | (spec moduleNamed: moduleName) ifNil: [ self noModuleError: moduleName ] ]
							  ifNil: [ spec ] ]
				  ifNil: [ self noSpecificationError ] ]
]

{ #category : 'private' }
MicViennaBlock >> recompose [

	presenter ifNotNil: #recompose
]

{ #category : 'accessing' }
MicViennaBlock >> resultString [

	^ resultString
]

{ #category : 'accessing' }
MicViennaBlock >> resultString: anObject [

	resultString := anObject
]

{ #category : 'private' }
MicViennaBlock >> retrievePresenter [

	presenter := ViennaMicrodownPresenterRequest signal
]

{ #category : 'accessing' }
MicViennaBlock >> specification [

	^ (presenter ifNotNil: #transpiledSpecification ifNil: [ self noSpecificationError ]) ifNotNil: #specification
]

{ #category : 'accessing' }
MicViennaBlock >> transpiledReceiver [

	^ self transpiledSpecification ifNotNil: [ :transpiledSpec |
			  self moduleName
				  ifNotNil: [ :moduleName | transpiledSpec at: moduleName ifAbsent: [ self errorString: 'No module named ' , moduleName ] ]
				  ifNil: [ transpiledSpec ] ]
]

{ #category : 'accessing' }
MicViennaBlock >> transpiledSpecification [

	^ presenter ifNotNil: #transpiledSpecification ifNil: [ self noSpecificationError ]
]

{ #category : 'accessing' }
MicViennaBlock >> vdmParser [

	^ vdmParser ifNil: [ vdmParser := self createVdmParser ]
]
