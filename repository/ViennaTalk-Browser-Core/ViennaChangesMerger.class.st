Class {
	#name : 'ViennaChangesMerger',
	#superclass : 'SpPresenter',
	#instVars : [
		'leftDefinitionList',
		'rightDefinitionList',
		'sourceText',
		'mergedDefinitionList',
		'resolvedGlobals'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'initialization' }
ViennaChangesMerger >> initialize [

	super initialize.
	resolvedGlobals := Set new
]

{ #category : 'initialization' }
ViennaChangesMerger >> initializePresenters [

	super initializePresenters.
	leftDefinitionList := self newTable
		                      addColumn: ((SpStringTableColumn
				                        title: 'module'
				                        evaluated: [ :node |
					                        node module
						                        ifNotNil: #identifier
						                        ifNil: [ '-' ] ])
				                       displayColor: [ :node |
					                       (node allGlobalNamesSatisfy: [ :name |
							                        resolvedGlobals includes: name ])
						                       ifTrue: [ Color lightGray ]
						                       ifFalse: [ Color black ] ];
				                       yourself);
		                      addColumn: ((SpStringTableColumn
				                        title: 'identifiers'
				                        evaluated: [ :node |
					                        ',' join: node identifiers ])
				                       displayColor: [ :node |
					                       (node allGlobalNamesSatisfy: [ :name |
							                        resolvedGlobals includes: name ])
						                       ifTrue: [ Color lightGray ]
						                       ifFalse: [ Color black ] ];
				                       yourself);
		                      items: #(  ).
	rightDefinitionList := self newTable
		                       addColumn: ((SpStringTableColumn
				                         title: 'module'
				                         evaluated: [ :node |
					                         node module
						                         ifNotNil: #identifier
						                         ifNil: [ '-' ] ])
				                        displayColor: [ :node |
					                        (node allGlobalNamesSatisfy: [ :name |
							                         resolvedGlobals includes: name ])
						                        ifTrue: [ Color lightGray ]
						                        ifFalse: [ Color black ] ];
				                        yourself);
		                       addColumn: ((SpStringTableColumn
				                         title: 'identifiers'
				                         evaluated: [ :node |
					                         ',' join: node identifiers ])
				                        displayColor: [ :node |
					                        (node allGlobalNamesSatisfy: [ :name |
							                         resolvedGlobals includes: name ])
						                        ifTrue: [ Color lightGray ]
						                        ifFalse: [ Color black ] ];
				                        yourself);
		                       items: #(  ).
	sourceText := self newVDMSource.
	mergedDefinitionList := self newTable
		                        addColumn: (SpStringTableColumn
				                         title: 'module'
				                         evaluated: [ :node |
					                         node module
						                         ifNotNil: #identifier
						                         ifNil: [ '-' ] ]);
		                        addColumn: (SpStringTableColumn
				                         title: 'identifiers'
				                         evaluated: [ :node |
					                         ',' join: node identifiers ]);
		                        items: #(  )
]
