Class {
	#name : 'MicViennaBlock',
	#superclass : 'MicScriptBlock',
	#instVars : [
		'vdmParser',
		'vdmHighlighter',
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
MicViennaBlock >> animation [

	^ presenter ifNotNil: #animation ifNil: [ ViennaTranspiledAnimation new ]
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

{ #category : 'accessing' }
MicViennaBlock >> bodyText [

	^ (self body asString trim ifNotEmpty: [ :bodyString | self vdmHighlight: bodyString ]) asText
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
MicViennaBlock >> noDefinitionError: aString [

	^ self errorString: 'No definition of ' , aString
]

{ #category : 'error messaging' }
MicViennaBlock >> noModuleError: aString [

	^ self errorString: 'No module named ' , aString
]

{ #category : 'error messaging' }
MicViennaBlock >> noSpecificationError [

	^ self errorString: 'Specification is not available'
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
MicViennaBlock >> resultString: aString [

	resultString := aString
]

{ #category : 'private' }
MicViennaBlock >> retrievePresenter [

	presenter := ViennaMicrodownPresenterRequest signal
]

{ #category : 'error messaging' }
MicViennaBlock >> syntaxError [

	^ self errorString: 'Syntax error in the body'
]

{ #category : 'error messaging' }
MicViennaBlock >> undefinedVariableError: aString [

	^ self errorString: 'Undefined variable ' , aString
]

{ #category : 'private' }
MicViennaBlock >> vdmHighlight: aString [

	^ (vdmHighlighter ifNil: [ vdmHighlighter := ViennaVDMHighlighter new ])
		  text: aString asText;
		  parse: aString asString;
		  text
]

{ #category : 'accessing' }
MicViennaBlock >> vdmParser [

	^ vdmParser ifNil: [ vdmParser := self createVdmParser ]
]
