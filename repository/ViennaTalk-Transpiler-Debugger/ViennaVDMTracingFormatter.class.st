Class {
	#name : 'ViennaVDMTracingFormatter',
	#superclass : 'ViennaVDMFormatter',
	#category : 'ViennaTalk-Transpiler-Debugger',
	#package : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : 'formatting' }
ViennaVDMTracingFormatter >> format: aViennaNode [
	^ (super format: aViennaNode) asViennaTracingString: aViennaNode
]

{ #category : 'private' }
ViennaVDMTracingFormatter >> join: aString withAll: aCollectionOfString [

	^ aCollectionOfString
		  ifNotEmpty: [
			  | string |
			  string := self empty , aCollectionOfString first.
			  2 to: aCollectionOfString size do: [ :index |
				  string := string , aString , (aCollectionOfString at: index) ].
			  string ]
		  ifEmpty: [ self empty ]
]
