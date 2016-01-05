user interface
buildPublishButton
	^ (PluggableButtonMorph
		on: self
		getState: #isPublished
		action: #togglePublish
		label: #publishButtonLabel)
		setBalloonText: 'toggle service on/off';
		color:
				(self isPublished
						ifTrue: [ self publishButtonOnColor ]
						ifFalse: [ self publishButtonOffColor ]);
		yourself