"
I am a block containing a mermaid script.

A script showing my visitors:
```language=text
 ```mermaid
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
 ```
```
Gives:
```mermaid
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
```
 
You can also specify the extent of the image like

```language=text
 ```mermaid|extent=100@150
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
 ```
```
Gives:
```mermaid|extent=100@150
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
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
