Extension { #name : 'WideSymbol' }

{ #category : '*ViennaTalk-Browser-Core' }
WideSymbol >> asLGitExternalString [
	^ self asUTF8Bytes asString asLGitExternalString
]
