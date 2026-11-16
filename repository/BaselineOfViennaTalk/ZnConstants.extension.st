Extension { #name : 'ZnConstants' }

{ #category : '*BaselineOfViennaTalk' }
ZnConstants class >> maximumLineLength [
	"Return the maximum line length to accept.
	Used by ZnLineReader and thus for reading request/status lines as well as headers.
	This helps to protect us from malicious content."

	^ 16384 "4096*4"
]
