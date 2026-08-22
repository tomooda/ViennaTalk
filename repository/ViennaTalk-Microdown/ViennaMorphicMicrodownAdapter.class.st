"
A morphic adapter for `MicrodownPresenter`
"
Class {
	#name : 'ViennaMorphicMicrodownAdapter',
	#superclass : 'MicMorphicTextAdapter',
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'factory' }
ViennaMorphicMicrodownAdapter >> buildWidget [
	| newWidget |

	newWidget := super buildWidget.

	self composeOn: newWidget.
	self presenter whenDocumentChangedDo: [ :aDocument | self compose ].
	self presenter whenTextStylerChangedDo: [ :aStyler | self compose ].

	^ newWidget
]

{ #category : 'composing' }
ViennaMorphicMicrodownAdapter >> compose [

	self widgetDo: [ :w | self composeOn: w ]
]

{ #category : 'composing' }
ViennaMorphicMicrodownAdapter >> composeOn: aWidget [

	self presenter document ifNil: [ ^ self ].
	self presenter text: ([
			 MicRichTextComposer new
				 textStyler: self presenter textStyler;
				 asRichText: self presenter document ]
			 on: ViennaMicrodownPresenterRequest
			 do: [ :ex | ex resume: self presenter ])
]

{ #category : 'accessing' }
ViennaMorphicMicrodownAdapter >> interactionModel [

	^ nil
]

{ #category : 'composing' }
ViennaMorphicMicrodownAdapter >> recompose [

	self widgetDo: [ :w | self recomposeOn: w ]
]

{ #category : 'composing' }
ViennaMorphicMicrodownAdapter >> recomposeOn: aWidget [

	self presenter document ifNil: [ ^ self ].
	self presenter setText: ([
			 MicRichTextComposer new
				 textStyler: self presenter textStyler;
				 asRichText: self presenter document ]
			 on: ViennaMicrodownPresenterRequest
			 do: [ :ex | ex resume: self presenter ])
]

{ #category : 'presenter->morph' }
ViennaMorphicMicrodownAdapter >> setText: aText to: aWidget [
	"called by presenter to set text in morph"

	scalingImageIndexes := (1 to: aText size)
		select: [ :idx |
			((aText at: idx) = Character home)
			and: [ (aText attributeAt: idx ofKind: MicScalingTextAnchor) notNil ] ].

	aWidget
		setText: aText;
		resetState
]
