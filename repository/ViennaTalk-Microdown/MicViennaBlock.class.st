Class {
	#name : 'MicViennaBlock',
	#superclass : 'MicScriptBlock',
	#instVars : [
		'vdmParser',
		'vdmHighlighter',
		'presenter',
		'resultString',
		'errorString',
		'bodyNode'
	],
	#classVars : [
		'GeneralVDMParser'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'accessing' }
MicViennaBlock class >> generalVDMParser [

	^ GeneralVDMParser ifNil: [
			  | parser |
			  parser := ViennaVDMParser new.
			  GeneralVDMParser := parser document end / parser namedTrace end / parser importModuleSignature end
			                      / parser accessTypeDefinition end / parser accessValueDefinition end / parser stateDefinition end
			                      / parser accessFunctionDefinition end / parser accessOperationDefinition end / parser statement end
			                      / parser expression end / parser type end / parser unitType end / parser importDefinition end
			                      / parser typeImport end / parser valueImport end / parser functionImport end / parser operationImport ]
]

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

	^ bodyNode ifNil: [
			  self body asString trim
				  ifNotEmpty: [ :bodyString |
						  bodyNode := self vdmParser parse: bodyString.
						  bodyNode isPetit2Success
							  ifTrue: [
									  (self animation ifNotNil: #specificationNode) ifNotNil: [ :specificationNode |
											  bodyNode parent:
												  (self moduleName ifNil: [ specificationNode ] ifNotNil: [ :moduleName | specificationNode moduleNamed: moduleName ]) ].
									  bodyNode ]
							  ifFalse: [
									  self syntaxError.
									  bodyNode ] ]
				  ifEmpty: [ nil ] ]
]

{ #category : 'accessing' }
MicViennaBlock >> bodyText [

	^ self bodyNode highlightedSource
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
MicViennaBlock >> generalVDMParser [

	^ self class generalVDMParser
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

{ #category : 'private' }
MicViennaBlock >> vdmHighlight: aString parent: aViennaNode [

	| node |
	node := self generalVDMParser parse: aString.
	^ node isPetit2Success
		  ifTrue: [ node highlightedSource ]
		  ifFalse: [ aString asText ]
]

{ #category : 'accessing' }
MicViennaBlock >> vdmParser [

	^ vdmParser ifNil: [ vdmParser := self createVdmParser ]
]
