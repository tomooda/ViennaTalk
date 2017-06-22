building presentations
vdmSourceIn: composite forContext: aContext
	(self vdmSourceWidgetIn: composite forContext: aContext)
		initialize: [ :code | code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installVDMSourceActionsFor: code ]