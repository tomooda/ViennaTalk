"
I am a block containing a mermaid script.

A script showing my visitors:
```language=text
 ```vdmsl
module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter(0)
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return count
end Counter
 ```
```
Gives:
```vdmsl
module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter(0)
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return count
end Counter
```

"
Class {
	#name : 'MicViennaTalkScriptBlock',
	#superclass : 'MicScriptBlock',
	#category : 'ViennaTalk-Parser-Highlighters',
	#package : 'ViennaTalk-Parser-Highlighters'
}

{ #category : 'accessing' }
MicViennaTalkScriptBlock class >> tag [

	^ #vdmsl
]

{ #category : 'visiting' }
MicViennaTalkScriptBlock >> accept: aVisitor [
	aVisitor visitViennaTalkScript: self 
]
