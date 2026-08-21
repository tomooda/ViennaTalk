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
