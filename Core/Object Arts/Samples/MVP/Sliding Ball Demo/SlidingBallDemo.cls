"Filed out from Dolphin Smalltalk 7"!

DoubleBufferedView subclass: #SlidingBallDemo
	instanceVariableNames: 'start end circle stepProcess'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SlidingBallDemo guid: (GUID fromString: '{e5ba81f2-42e7-43ee-832f-3a24fadebfee}')!
SlidingBallDemo comment: 'I would like the example to have two rectangles connected by a line.
One button (called "start") that when presssed will show a small
circle travel along the line from one rectangle to the other. Upon
reaching the second rectangle the circle disappears and a dialog box
appears stating the "The package has arrived"...this would then
display for 5 seconds and then disappear.
At any time after the "start" button has been pressed the user can
pause the circle''s movement by clicking anywhere in the workspace and
start it again from where it was stopped by also clicking anywhere in
the work space (I would consider another button that would be where
the user is required to pause and restart the movement)

SlidingBallDemo new show'!
!SlidingBallDemo categoriesForClass!Unclassified! !
!SlidingBallDemo methodsFor!

circleExtent
	^20@20!

circleVelocity
	^6.5!

defaultExtent
	^400@400!

defaultWindowStyle
	"Private - Answer the default basic window creation style"

	^##(WS_THICKFRAME | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX)!

frameRate
	^30!

initialize
	super initialize.
	start := 120@70.
	end := 300@190.
	circle := start.
	self text: 'Sliding Ball Demonstration'.
!

isCompleted
	| endBox |
	endBox := Rectangle center: end extent: self rectangleExtent.
	^endBox containsPoint: circle
!

isRunning
	^stepProcess notNil!

onDestroyed
	self stopStepProcess.
	^super onDestroyed!

onLeftButtonDoubleClicked: aMouseEvent
	super onLeftButtonDoubleClicked: aMouseEvent.
	self isRunning 
		ifTrue: [self stopStepProcess]
		ifFalse: [self startStepProcess].
	self invalidate
!

paintCircleOn: aCanvas 
	aCanvas
		pen: (Pen color: Color magenta);
		brush: Color magenta brush;
		ellipse: (Rectangle center: circle rounded extent: self circleExtent)!

paintEndOn: aCanvas 
	| aRectangle aColor |
	aRectangle := Rectangle center: end extent: self rectangleExtent.
	aColor := Color red.
	aCanvas fillRectangle: aRectangle color: aColor!

paintLineOn: aCanvas
	aCanvas
		pen: (Pen blue width: 3);
		moveTo: start;
		lineTo: end
!

paintStartOn: aCanvas 
	aCanvas fillRectangle: (Rectangle center: start extent: self rectangleExtent)
		color: Color green!

rectangleExtent
	^50@50!

render
	"Private - Render the background image"

	| canvas |

	canvas := self canvas.
	canvas erase.
	self paintLineOn: canvas.
	self paintStartOn: canvas.
	self paintEndOn: canvas.
	self paintCircleOn: canvas.
	self isRunning 
		ifFalse: [ self showStartMessageOn: canvas ].

	canvas free. "useful to avoid build up of finalizable garbage"
	super render
!

showCompletedMessage
	"It is not straightforward to automatically terminate a standard MessgaeBox so for 
	expendiency we use a custom Splash screen"

	| bm |
	bm := DIBSection width: 200 height: 100.
	(bm canvas)
		forecolor: Color white;
		backgroundMode: TRANSPARENT;
		text: 'The package has arrived' at: 20 @ 40.
	(Splash new)
		bitmap: bm;
		showTimed: (Delay forSeconds: 5)!

showStartMessageOn: aCanvas
	aCanvas 
		font: (Font name: 'Arial' pointSize: 12);
		text: 'Double click to start' at: 100@250!

startStepProcess
	stepProcess := [[Processor sleep: (1000 // self frameRate). self step] repeat ] fork!

step
	| unitStep |
	unitStep := (end-start) / 1000.
	circle := circle + (unitStep*self circleVelocity).
	self invalidate.
	self isCompleted ifTrue: [
		self showCompletedMessage.
		self stopStepProcess ].
!

stepProcess
	"Private - Answer the value of the receiver's ''stepProcess'' instance variable."

	^stepProcess!

stopStepProcess
	self isRunning ifTrue: [
		self stepProcess terminate.
		stepProcess := nil ]! !
!SlidingBallDemo categoriesFor: #circleExtent!constants!public! !
!SlidingBallDemo categoriesFor: #circleVelocity!constants!public! !
!SlidingBallDemo categoriesFor: #defaultExtent!constants!public! !
!SlidingBallDemo categoriesFor: #defaultWindowStyle!constants!private! !
!SlidingBallDemo categoriesFor: #frameRate!constants!public! !
!SlidingBallDemo categoriesFor: #initialize!event handling!private! !
!SlidingBallDemo categoriesFor: #isCompleted!private!testing! !
!SlidingBallDemo categoriesFor: #isRunning!private!testing! !
!SlidingBallDemo categoriesFor: #onDestroyed!event handling!private! !
!SlidingBallDemo categoriesFor: #onLeftButtonDoubleClicked:!event handling!private! !
!SlidingBallDemo categoriesFor: #paintCircleOn:!displaying!public! !
!SlidingBallDemo categoriesFor: #paintEndOn:!displaying!private! !
!SlidingBallDemo categoriesFor: #paintLineOn:!displaying!private! !
!SlidingBallDemo categoriesFor: #paintStartOn:!displaying!private! !
!SlidingBallDemo categoriesFor: #rectangleExtent!constants!public! !
!SlidingBallDemo categoriesFor: #render!operations!private! !
!SlidingBallDemo categoriesFor: #showCompletedMessage!operations!private! !
!SlidingBallDemo categoriesFor: #showStartMessageOn:!displaying!private! !
!SlidingBallDemo categoriesFor: #startStepProcess!initializing!private! !
!SlidingBallDemo categoriesFor: #step!operations!private! !
!SlidingBallDemo categoriesFor: #stepProcess!accessing!private! !
!SlidingBallDemo categoriesFor: #stopStepProcess!initializing!private! !

