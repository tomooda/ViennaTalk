Extension { #name : #VirtualMachine }

{ #category : #'*ViennaTalk-Engine-Core' }
VirtualMachine >> fullPath [
	"Return the full vm path as a string"
	"Ex: '/Applications/.../Contents/MacOS/vm '"
	"SmalltalkImage current vm fullPath"

	^ (self getSystemAttribute: 0) asByteArray decodeWith:
		  OSEnvironment current defaultEncoding
]
