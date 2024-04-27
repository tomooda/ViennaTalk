Class {
	#name : #ViennaTracesDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
