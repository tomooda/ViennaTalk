Extension { #name : 'WideString' }

{ #category : '*ViennaTalk-Browser-Core' }
WideString >> asLGitExternalString [
	^ self asUTF8Bytes asString asLGitExternalString
]
