Class {
	#name : #ViennaEditor,
	#superclass : #TextEditor,
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'class initialization' }
ViennaEditor class >> initialize [
	super initialize
]

{ #category : #'keyboard shortcut tables' }
ViennaEditor class >> initializeCmdKeyShortcuts [
	"Initialize the (unshifted) command-key (or alt-key) shortcut table."

	"
	ViennaEditor initialize
	"

	| cmds |
	self initializeBasicCmdKeyShortcuts.
	'0123456789-=' do: [ :char | cmdActions at: char asciiValue + 1 put: #changeEmphasis: ].
	cmds := #($d #doIt: $z #undo: $j #redo: $l #cancel: $p #printIt: $s #save:).
	1 to: cmds size by: 2 do: [ :i | self cmdActions at: (cmds at: i) asciiValue + 1 put: (cmds at: i + 1) ]
]

{ #category : #'keyboard shortcut tables' }
ViennaEditor class >> initializeShiftCmdKeyShortcuts [
	"Initialize the shift-command-key (or control-key) shortcut table."

	"wod 11/3/1998: Fix setting of cmdMap for shifted keys to actually use the 
	capitalized versions of the letters.
	TPR 2/18/99: add the plain ascii values back in for those VMs that don't return the shifted values."

	"ViennaEditor initialize"

	| cmds |
	self initializeBasicShiftCmdKeyShortcuts.
	self shiftCmdActions at: 45 + 1 put: #changeEmphasis:.	"cmd-sh-minus"
	self shiftCmdActions at: 61 + 1 put: #changeEmphasis:.	"cmd-sh-plus"
	cmds := #($f #format: $k #changeStyle:).
	1 to: cmds size by: 2 do: [ :i | 
		self shiftCmdActions at: (cmds at: i) asciiValue + 1 put: (cmds at: i + 1).	"plain keys"
		self shiftCmdActions at: (cmds at: i) asciiValue - 32 + 1 put: (cmds at: i + 1).	"shifted keys"
		self shiftCmdActions at: (cmds at: i) asciiValue - 96 + 1 put: (cmds at: i + 1)	"ctrl keys" ]
]

{ #category : #'do-its' }
ViennaEditor >> doIt [
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model doItIn: textMorph ]
]

{ #category : #'editing keys' }
ViennaEditor >> doIt: aKeyboardEvent [
	self doIt.
	^ true
]

{ #category : #'do-its' }
ViennaEditor >> format [
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model formatIn: textMorph ]
]

{ #category : #'editing keys' }
ViennaEditor >> format: aKeyboardEvent [
	self format.
	^ true
]

{ #category : #'typing support' }
ViennaEditor >> openTypeIn [
	"Set up startOfTyping to keep track of the leftmost backspace.
	 You can't undo typing until after closeTypeIn."

	self applyAttribute: TextColor black.
	^ super openTypeIn
]

{ #category : #'do-its' }
ViennaEditor >> printIt [
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model printItIn: textMorph ]
]

{ #category : #'editing keys' }
ViennaEditor >> printIt: aKeyboardEvent [
	self printIt.
	^ true
]

{ #category : #'editing keys' }
ViennaEditor >> save: aKeyboardEvent [
	self closeTypeIn.
	self accept.
	^ true
]

{ #category : #accessing }
ViennaEditor >> viennaTextMorph [
	| textMorph |
	textMorph := morph.
	[ textMorph notNil and: [ textMorph isKindOf: ViennaPluggableTextMorph ] ] whileFalse: [ textMorph := textMorph owner ].
	^ textMorph
]
