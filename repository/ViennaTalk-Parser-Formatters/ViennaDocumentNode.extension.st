Extension { #name : 'ViennaDocumentNode' }

{ #category : '*ViennaTalk-Parser-Formatters' }
ViennaDocumentNode >> asViennaDocScript [

	| sources walker |
	sources := Dictionary new.
	walker := [ :node :module |
		          node isViennaNode ifTrue: [
				          node isViennaModuleNode ifTrue: [
					          sources at: node identifier put: node source ].
				          node isViennaStateDefinitionNode ifTrue: [
						          sources
							          at:
							          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node identifier
							          put: node source ].
				          node isViennaExplicitOperationDefinitionNode ifTrue: [
						          sources
							          at:
							          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node identifier
							          put: node source ].
				          node isViennaTypeSynonymNode ifTrue: [
						          sources
							          at:
							          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node identifier
							          put: node source ].
				          node isViennaRecordTypeDefinitionNode ifTrue: [
						          sources
							          at:
							          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node identifier
							          put: node source ].
				          node isViennaValueDefinitionNode ifTrue: [
						          sources
							          at:
								          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
								          , node pattern identifier
							          put: node source ].
				          node isViennaExplicitFunctionDefinitionNode ifTrue: [
						          sources
							          at:
							          (module ifNil: [ '' ] ifNotNil: [ module , '`' ])
							          , node identifier
							          put: node source ].
				          node do: [ :n |
						          walker
							          value: n
							          value:
							          (module ifNil: [
								           node isViennaModuleNode ifTrue: [ node identifier ] ]) ] ] ].
	walker value: self value: nil.
	^ String streamContents: [ :stream |
			  stream nextPutAll: 'ViennaDoc.source='.
			  (NeoJSONWriter on: stream) nextPut:
				  self source withUnixLineEndings.
			  stream
				  nextPut: $;;
				  nextPut: Character lf;
				  nextPutAll: 'ViennaDoc.sources = {};';
				  nextPut: Character lf.
			  sources keysAndValuesDo: [ :name :src |
					  stream
						  nextPutAll: 'ViennaDoc.sources[';
						  nextPut: $';
						  nextPutAll: name;
						  nextPut: $';
						  nextPutAll: ']='.
					  (NeoJSONWriter on: stream) nextPut: src withUnixLineEndings.
					  stream
						  nextPut: $;;
						  nextPut: Character cr ] ]
]
