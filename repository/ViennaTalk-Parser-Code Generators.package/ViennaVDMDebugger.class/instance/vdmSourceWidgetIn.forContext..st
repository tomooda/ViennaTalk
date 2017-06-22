building presentations
vdmSourceWidgetIn: composite forContext: aContext

	^ composite vdmSource
		title: 'VDM';
		format: [ aContext specification ifNotNil: #highlightedSource ifNil: [ Text new ] ]