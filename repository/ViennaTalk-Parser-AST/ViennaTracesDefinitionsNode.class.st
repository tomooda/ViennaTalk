Class {
	#name : #ViennaTracesDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTracesDefinitionsNode >> isViennaTracesDefinitionsNode [

	^ true
]

{ #category : #accessing }
ViennaTracesDefinitionsNode >> label [

	^ 'TracesDefinitions'
]

{ #category : #'pretty printing' }
ViennaTracesDefinitionsNode >> sectionName [

	^ 'traces'
]
