"Filed out from Dolphin Smalltalk 7"!

ValueConvertingControlView subclass: #SpinButton
	instanceVariableNames: ''
	classVariableNames: 'AlignmentMap AlignmentMask UdnMap'
	poolDictionaries: 'UpDownControlConstants'
	classInstanceVariableNames: ''!
SpinButton guid: (GUID fromString: '{425d0eac-542e-11d3-998b-d5ca2c3c1d61}')!
SpinButton comment: 'SpinButton is a <valueView> wrapping the Windows Up-Down common control. The <valueModel> associated with a SpinButton must always yield an <integer> value when mapped through the installed type converter.

Note that comctl32.dll version 5.80 or later is required, mandating at least Internet Explorer 5 on the target machine. This is to support the 32-bit integer range, 16-bit seeming hardly worthwhile.

A SpinButton is essentially a collapsed scrollbar with no centre portion (i.e. just the up/down arrows). Pressing the buttons "nudges" a value in another field, usually a text field, known as the ''buddy''. Holding down the buttons will spin through the value sequence, accelerating as the button is held down. In Dolphin''s implementation the the UDS_AUTOBUDDY style, which causes the SpinButton to automatically buddy up with the previous control in the z-order, is used as the default. The alternative of explicitly setting the buddy is somewhat difficult to maintain in a dynamic environment, so the framework provides no support for this. 

The SpinButton can be configured to automatically set the text of its buddy to the decimal or hex representation of its integer value by enabling the #isAutoSync property. However it is recommended that the auto-sync mode not be used because it is only useful for cycling through a range of integer values, and its effect is easily achieved in MVP by associating the same model with the SpinButton and its buddy. For other enumerations (such as a set of symbolic names) one can synchronise the ''buddy'' view by observing the value change events of the SpinButton''s model, or by using some combination of ValueConverter and TypeConverter to convert the numeric index to a selection from a list.

The up-down control also has auto-layout behaviour, controlled by the alignment setting, which allows it to be configured to cling to the left or right side of its buddy control. Again this auto-layout behaviour is not that useful in Dolphin because the same can easily (and more flexibly) be achieved by using MVP layout managers. The alignment property is still exposed, however, because it affects the visual appearance of the control as well, changing its border style so that it can appear to be part of the buddy edit control, rather than a separate control. If the control has no buddy (possible by turning off #isAutoBuddy and setting #buddy to nil), then the alignment style is ignored so the control may not look right.

The SpinButton''s model is always an integer value in a defined interval (see below), which is updated as the arrow buttons are pressed. Before the update occurs a #nudge: event is triggered off the view''s presenter. The parameter to this event (an instance of <NMUPDOWN>) details the current  value (the position), and the proposed change in value (the delta). It also contains a boolean ''allow'' value, that can be set to false should an observer wish to veto the nudge. At the time the #nudge: event is transmitted, the value of the button has not yet been changed. To monitor changes to the actual value of the button, the #valueChanged event of its model should be observed in the normal way.

Note that the #range aspect is an integral <Interval> that may have a step other than 1. The value of the spin button should always be some element of the interval.

Class Variables:
	AlignmentMap	<LookupTable> mapping symbolic alignment modes to the corresponding integer flags.
	AlignmentMask	<Integer>
	UdnMap		<Array> of <Symbol>. Notification message selectors.

'!
!SpinButton categoriesForClass!MVP-Views! !
!SpinButton methodsFor!

alignment
	"Answer a <Symbol> identifiying the receiver's current alignment mode in relation
	to its buddy window. This is one of #left, #right, or #unattached."

	| alignment |
	alignment := self baseStyle bitAnd: AlignmentMask.
	AlignmentMap 
		keysAndValuesDo: [:eachKey :eachValue | (eachValue ~~ 0 and: [alignment allMask: eachValue]) ifTrue: [^eachKey]].
	^#unattached!

alignment: aSymbol 
	"Set the receiver's alignment mode in relation to its buddy window.
	The <Symbol> argument names the desired mode and can be one one of 
	#left, #right, or #unattached."

	self 
		baseStyle: (AlignmentMap at: aSymbol)
		maskedBy: AlignmentMask
		recreateIfChanged: true	"Must be recreated if changed, as style only respected on creation"!

buddy
	"Answer the receiver's 'buddy' <View> - this is the window to which the receiver is attached 
	for the purpose of nudging that view's value."

	| hWnd |
	hWnd := self sendMessage: UDM_GETBUDDY.
	^hWnd = 0 ifFalse: [View fromHandle: hWnd]!

buddy: aView 
	"Answer the receiver's 'buddy' <View> - this is the window to which the receiver is attached 
	for the purpose of nudging that view's value. Note that it doesn't make sense to set the buddy
	if the receiver is in auto-buddy mode."

	| visible |
	visible := self isWindowVisible.
	self sendMessage: UDM_SETBUDDY wParam: aView asParameter.
	"For some reason the up-down control sometimes hides itself when its buddy is changed"
	self isWindowVisible ~~ visible ifTrue: [self isWindowVisible: visible]!

displayValue
	^self 
		sendMessage: UDM_GETPOS32
		wParam: 0
		lpParam: nil!

displayValue: anInteger 
	self 
		sendMessage: UDM_SETPOS32
		wParam: 0
		lParam: anInteger!

getRange
	| min max |
	min := SDWORD new.
	max := SDWORD new.
	self 
		sendMessage: UDM_GETRANGE32
		wParam: min yourAddress
		lParam: max yourAddress.
	^min value to: max value!

getStep
	"Private - Answer the amount by which the spin button's value changes each time the button
	is pressed."

	| accel |
	accel := UDACCEL new.
	^(self 
		sendMessage: UDM_GETACCEL
		wParam: 1
		lpParam: accel) = 0 
		ifTrue: [1]
		ifFalse: [accel nInc]!

hasHotTracking
	"Answer whether the receiver has the hot-tracking style."

	^self baseStyleAllMask: UDS_HOTTRACK!

hasHotTracking: aBoolean 
	"Sets the receiver into or out of hot-tracking mode."

	self 
		baseStyleMask: UDS_HOTTRACK
		set: aBoolean
		recreateIfChanged: false!

hasThousandsSeparators
	"Answer whether the receiver displays thousands separators.
	This mode is irrelevent if the receiver is not auto-syncing with the buddy."

	^(self baseStyleAllMask: UDS_NOTHOUSANDS) not!

hasThousandsSeparators: aBoolean 
	"Set whether the receiver displays thousands separators.
	This mode is irrelevent if the receiver is not auto-syncing with the buddy."

	self baseStyleMask: UDS_NOTHOUSANDS set: aBoolean not recreateIfChanged: false!

initialize
	super initialize.
	self isAutoBuddy: true!

isAutoBuddy
	"Answer whether the receiver automatically buddies with its previous sibling."

	^self baseStyleAllMask: UDS_AUTOBUDDY!

isAutoBuddy: aBoolean 
	"Answer whether the receiver automatically buddies with its previous sibling."

	"Note that if we don't recreate when switching into auto-buddy mode, then the control makes
	no attempt to locate its buddy"
	self baseStyleMask: UDS_AUTOBUDDY set: aBoolean recreateIfChanged: true!

isAutoSync
	"Set whether the receiver updates the text of its buddy <TextEdit> when its own value
	changes."

	^self baseStyleAllMask: UDS_SETBUDDYINT!

isAutoSync: aBoolean 
	"Set whether the receiver updates the text of its buddy <TextEdit> when its own value
	changes."

	self baseStyleMask: UDS_SETBUDDYINT set: aBoolean recreateIfChanged: false!

isVertical
	"Answer whether the receiver has a vertical orientation (the default)."

	^(self baseStyleAllMask: UDS_HORZ) not!

isVertical: aBoolean 
	"Set whether the receiver has a vertical orientation (the default)."

	self 
		baseStyleMask: UDS_HORZ
		set: aBoolean not
		recreateIfChanged: true!

isWraparound
	"Answer whether the receiver wraps from max to min value."

	^self baseStyleAllMask: UDS_WRAP!

isWraparound: aBoolean 
	"Set whether the receiver wraps from max to min value."

	self baseStyleMask: UDS_WRAP set: aBoolean recreateIfChanged: true!

nmNotify: pNMHDR
	"Private - Handle a redirected WM_NOTIFY message from the control."

	"Implementation Note: Rather than create the appropriate header structure object here, we
	delay that until the handler, because most of the time we don't need to look at the
	notification at all."

	^(UdnMap lookup: UDN_FIRST - (pNMHDR sdwordAtOffset: 8))
		ifNil: [super nmNotify: pNMHDR]
		ifNotNil: [:action | self perform: action with: pNMHDR]!

onHScroll: aScrollEvent 
	"The receiver has been changed so just update the model to track it"

	self updateModel.
	^0!

onPositionChanged: aPositionEvent 
	"Handle a window position change (move or resize)."

	(aPositionEvent isZOrderChanged and: [self isAutoBuddy]) ifTrue: [self buddy: nil].
	^super onPositionChanged: aPositionEvent!

onVScroll: aScrollEvent 
	"The receiver has been nudged so update the model to track it."

	self updateModel.
	^0!

radix
	"Answer the <integer> base in which the receiver displays its value. This will be either 10
	(decimal) or 16 (hex). This is only relevant if the #isAutoSync aspect is true."

	^self sendMessage: UDM_GETBASE!

radix: anInteger 
	"Set the <integer> base in which the receiver displays its value. This must be either 10
	(decimal) or 16 (hex). This is only relevant if the #isAutoSync aspect is true."

	(self sendMessage: UDM_SETBASE wParam: anInteger) == 0 
		ifTrue: [self error: 'Invalid radix: ' , anInteger printString]!

range
	"Answer an integer <Interval> which specifies the range over which the receiver steps."

	| range |
	range := self getRange.
	range step: self getStep.
	^range!

range: anInterval 
	"Set the range over which the receiver steps to the integer sequence specified by the
	<Interval> argument."

	self setRange: anInterval.
	self setStep: anInterval step!

setRange: anInterval 
	self 
		sendMessage: UDM_SETRANGE32
		wParam: anInterval start
		lParam: anInterval stop!

setStep: anInteger 
	"Private - Set the amount by which the spin button's value changes each time a button is
	pressed. Note that this adjusts all the accelerated jumps to be multiples of the step,
	attempting to maintain approximately the existing acceleration ratios."

	| accels prevStep |
	accels := self udmGetAccel.
	prevStep := accels isEmpty 
				ifTrue: 
					[accels := StructureArray length: 1 elementClass: UDACCEL.
					1]
				ifFalse: [accels first nInc].
	(accels first)
		nInc: anInteger;
		nSec: 0.
	accels from: 2 do: [:each | each nInc: (each nInc / prevStep * anInteger) truncated].
	self udmSetAccel: accels!

state
	"Private - Answer a <MessageSequence> which, when replayed, will restore the receiver 
	to its current state."

	| answer |
	answer := super state.
	answer
		add: (MessageSend 
					receiver: self
					selector: #setRange:
					argument: self getRange);
		add: (MessageSend 
					receiver: self
					selector: #udmSetAccel:
					argument: self udmGetAccel).
	^answer!

udmGetAccel
	"Private - Answer the acceleration information for the control (see MSDN)."

	| answer count |
	count := self sendMessage: UDM_GETACCEL.
	answer := StructureArray length: count elementClass: UDACCEL.
	self 
		sendMessage: UDM_GETACCEL
		wParam: count
		lpParam: answer.
	^answer!

udmSetAccel: aStructureArrayOfUDACCEL 
	"Private - Set the acceleration information for the receiver, answering whether the
	acceleration settings were successfully installed."

	^self 
		sendMessage: UDM_SETACCEL
		wParam: aStructureArrayOfUDACCEL size
		lpParam: aStructureArrayOfUDACCEL!

udnDeltaPos: anExternalAddress 
	"Private - Handle the UDN_DELTAPOS notification from the control, sent when the position of
	the up-down control is about to change. An event is triggered and observers may veto the
	position change by setting the #allow property of the event argument to false."

	| nmud |
	self isStateRestoring ifTrue: [^false].
	nmud := NMUPDOWN fromAddress: anExternalAddress.
	nmud allow: true.
	self presenter trigger: #nudge: with: nmud.
	^nmud allow ifTrue: [0] ifFalse: [1]!

wantArrowKeys
	"Answer whether the receiver spins up and down in response to the keyboard arrow keys."

	^self baseStyleAllMask: UDS_ARROWKEYS!

wantArrowKeys: aBoolean 
	"Answer whether the receiver spins up and down in response to the keyboard arrow keys."

	self 
		baseStyleMask: UDS_ARROWKEYS
		set: aBoolean
		recreateIfChanged: false! !
!SpinButton categoriesFor: #alignment!accessing!public! !
!SpinButton categoriesFor: #alignment:!accessing!public! !
!SpinButton categoriesFor: #buddy!accessing!public! !
!SpinButton categoriesFor: #buddy:!accessing!public! !
!SpinButton categoriesFor: #displayValue!private!updating! !
!SpinButton categoriesFor: #displayValue:!private!updating! !
!SpinButton categoriesFor: #getRange!accessing!private! !
!SpinButton categoriesFor: #getStep!accessing!private! !
!SpinButton categoriesFor: #hasHotTracking!accessing-styles!public! !
!SpinButton categoriesFor: #hasHotTracking:!accessing-styles!public! !
!SpinButton categoriesFor: #hasThousandsSeparators!accessing-styles!public! !
!SpinButton categoriesFor: #hasThousandsSeparators:!accessing-styles!public! !
!SpinButton categoriesFor: #initialize!initializing!public! !
!SpinButton categoriesFor: #isAutoBuddy!accessing-styles!public! !
!SpinButton categoriesFor: #isAutoBuddy:!accessing-styles!public! !
!SpinButton categoriesFor: #isAutoSync!accessing-styles!public! !
!SpinButton categoriesFor: #isAutoSync:!accessing-styles!public! !
!SpinButton categoriesFor: #isVertical!accessing-styles!public! !
!SpinButton categoriesFor: #isVertical:!accessing-styles!public! !
!SpinButton categoriesFor: #isWraparound!accessing-styles!public! !
!SpinButton categoriesFor: #isWraparound:!accessing-styles!public! !
!SpinButton categoriesFor: #nmNotify:!event handling-win32!private! !
!SpinButton categoriesFor: #onHScroll:!event handling!private! !
!SpinButton categoriesFor: #onPositionChanged:!event handling!public! !
!SpinButton categoriesFor: #onVScroll:!event handling!private! !
!SpinButton categoriesFor: #radix!accessing!public! !
!SpinButton categoriesFor: #radix:!accessing!public! !
!SpinButton categoriesFor: #range!accessing!public! !
!SpinButton categoriesFor: #range:!accessing!public! !
!SpinButton categoriesFor: #setRange:!accessing!private! !
!SpinButton categoriesFor: #setStep:!accessing!private! !
!SpinButton categoriesFor: #state!accessing!private! !
!SpinButton categoriesFor: #udmGetAccel!accessing!private! !
!SpinButton categoriesFor: #udmSetAccel:!accessing!private! !
!SpinButton categoriesFor: #udnDeltaPos:!event handling-win32!private! !
!SpinButton categoriesFor: #wantArrowKeys!accessing-styles!public! !
!SpinButton categoriesFor: #wantArrowKeys:!accessing-styles!public! !

!SpinButton class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^0 asValue!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	AlignmentMask := ##(UDS_ALIGNLEFT | UDS_ALIGNRIGHT).
	AlignmentMap := (LookupTable new)
				at: #left put: UDS_ALIGNLEFT;
				at: #right put: UDS_ALIGNRIGHT;
				at: #unattached put: 0;
				shrink;
				yourself.
	self initializeNotificationMap!

initializeNotificationMap
	"Implementation Note: At present there is only one notification, but follow the normal
	notification map idiom in case further events are added at a later date."

	UdnMap := (Array new: 1)
				at: UDN_FIRST - UDN_DELTAPOS put: #udnDeltaPos:;
				yourself!

winClassName
	"Private - Answer the name of the Windows window class to use when realizing the receiver."

	^'msctls_updown32'! !
!SpinButton class categoriesFor: #defaultModel!models!public! !
!SpinButton class categoriesFor: #icon!constants!public! !
!SpinButton class categoriesFor: #initialize!initializing!private! !
!SpinButton class categoriesFor: #initializeNotificationMap!initializing!must not strip!private! !
!SpinButton class categoriesFor: #winClassName!constants!private! !

