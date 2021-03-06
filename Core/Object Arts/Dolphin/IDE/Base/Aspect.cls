"Filed out from Dolphin Smalltalk 7"!

AttributeDescriptor subclass: #Aspect
	instanceVariableNames: 'name presenterBlock editBlock immediateActionBlock category isPresenterBlockReadOnly'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Aspect guid: (GUID fromString: '{87b4c4d7-026e-11d3-9fd7-00a0cc3e4a32}')!
Aspect comment: 'Part of the PublishedAspectorInspector framework.

<Aspect>s are used to describe the published aspects of various objects. An Aspect descriptor can be combined with a particular object to create an <AspectAccessor> that can be used to access the subject object with the value/value> protocol. The <AspectAccessor> uses the aspect name to construct accessor messages (e.g. #myAspect and #myAspect:) for getting and setting the value. An Aspect instance also holds a presenter block (a <dyadicValuable>) which, when evaluated, will create a presenter suitable for editing the aspect as its model.

All objects understand the #publishedAspects message, which is used to answer a <LookupTable> (keyed on aspect name) of all the Aspect descriptors that are published by the object. This additional meta-information is used by the development tools (in particular the <PublishedAspectInspector>) to easily allow user interface editing of various objects. Classes wishing allow such editing must publish aspects for their instances, and should do this by overriding the #publishedAspectsOfInstances method to add appropriate Aspects to this table.

Instance Variables:
	name		<Symbol> identifying the aspect.
	presenterBlock	<dyadicValuable> to be evaluated to bring up a presenter on the aspect
	editBlock		<monadicValue> to be evaluated to edit the aspect
	isMutable		<Boolean> specifying whether the aspect can be modified in-place'!
!Aspect categoriesForClass!Development! !
!Aspect methodsFor!

<= anAspect
	"Answer whether the receiver is 'less than' anAspect..
	By implementing this method, we enable Aspect objects to be stored
	in a SortedCollection with the default sort block."

	^(self species == anAspect species) 
		ifTrue: [self name <= anAspect name]
		ifFalse: [ self species <= anAspect species]!

= comperand
	"Answer whether the receiver is considered equal to the <Object>, comperand."

	^self == comperand or: [self species == comperand species and: [self name == comperand name]]!

accessorClass
	^AspectAccessor!

accessorFor: anObject 
	"Answers an AspectAccessor value adaptor for the receiver on anObject"

	^self accessorClass subject: anObject aspect: self!

beImmediateActionIsEdit
	"Some aspects can use their edit block to perform an immediate action. Set this here"

	immediateActionBlock := editBlock!

bePresenterBlockReadOnly
	"Informs the receiver that the presenterBlock is only capable of reading aspect values and
	not setting them. This is ised by the PropertyEditor in particular to swap out a
	presenterBlock for the default block when the priovided block is read only."

	isPresenterBlockReadOnly := true!

canEdit
	"Answer true if the receiver can be edited; that is, it has an edit block
	defined for it"

	^self editBlock notNil!

canGenerateAccessors
	"Private - Answer true if instances of the receiver can generate code for attribute
	accessor methods. Aspects accessors cannot be generated"

	^false!

canImmediateAction
	"Answer true if the receiver can be actioned immediately; that is, it has an immediateAction block
	defined for it"

	^self immediateActionBlock notNil!

canReadFrom: anObject
	^self isReadable and: [anObject respondsTo: self getSelector]!

canWriteInto: anObject
	^self isWriteable and: [anObject respondsTo: self putSelector]!

category
	^category!

category: aSymbol 
	category := aSymbol!

defaultFlags
	^WriteableMask | ReadableMask | MutableMask | NullableMask!

displayAspectInfoOf: anObject on: aStream 
	self displayAspectValueOf: anObject on: aStream!

displayAspectNameOf: anObject on: aStream 
	self name == #yourself ifTrue: [aStream nextPutAll: 'self' ] ifFalse: [aStream display: self]!

displayAspectText: anObject on: aStream 
	self name == #yourself 
		ifFalse: 
			[self displayAspectNameOf: anObject on: aStream.
			"Note that the #yourself aspect must be readable"
			self isBrowsable ifFalse: [^self].
			aStream nextPut: $=].
	self displayAspectValueOf: anObject on: aStream!

displayAspectValueOf: anObject on: aStream 
	(self readFrom: anObject) aspectDisplayOn: aStream!

displayOn: aStream
	"Append the receiver to aStream in a format that a user would want to see"

	aStream display: self name!

editablePresenterBlock
	"Answer the presenter block that can definitely be used to display AND edit the receiver's aspect"

	^self isPresenterBlockReadOnly 
		ifTrue: [self class defaultPresenterBlock]
		ifFalse: [self presenterBlock]!

editablePresenterFor: aValueModel in: aCompositePresenter 
	"Answer a new <Presenter> to edit the aspect accessed by the <AspectAccessor> argument
	within the <CompositePresenter> argument. If the presenterBlock installed in the receiver is
	readonly then we use the defaultPresenterBlock instead."

	^self editablePresenterBlock value: aCompositePresenter value: aValueModel!

editBlock
	"Private - Answer the <monadicValuable> that can be used to edit the receiver's aspect."

	^editBlock!

getSelector
	"Private - Answers the selector used for getting the aspect value from the subject"

	^self name
!

hash
	"Answer the <Integer> hash value for the receiver."

	^self name hash!

immediateActionBlock
	"Private - Answer the <monadicValuable> that can be used to immediately action the receiver's aspect."

	^immediateActionBlock!

isDefaultPresenterBlock
	"Answer true if we will use a default presenter block for displaying/editing the receiver"

	^self editablePresenterBlock == self class defaultPresenterBlock!

isPresenterBlockReadOnly
	"Answers true if the presenterBlock is only capable of reading aspect values and
	not setting them. This is used by the PropertyEditor in particular to swap out a
	presenterBlock for the default block when the priovided block is read only."

	^isPresenterBlockReadOnly!

key
	"Private - Answer the lookup key of the receiver when it is to appear as an
	association (Aspects can be stored directly in Dictionaries)"

	^self name!

name
	"Answer the aspect name Symbol of the receiver"

	^name!

name: aSymbol presenterBlock: aOneArgPresenterBlock editBlock: aOneArgEditBlock
	"Private - Initialize the receiver; set the name to aSymbol and the 
	editor presenter creation block to aOneArgBlock"

	name := aSymbol.
	presenterBlock := aOneArgPresenterBlock.
	editBlock := aOneArgEditBlock.
	isPresenterBlockReadOnly := false.
!

nameIn: anObject
	"Private - Answer the 'name' of the aspect of the <Object> argument described by the receiver."

	^name!

objectRefName: anObject
	^self name!

presenterBlock
	"Answer the <dyadicValuable> capable of creating a presenter for the receiver's
	 aspect name"

	^presenterBlock!

presenterFor: aValueModel in: aCompositePresenter
	"Answer a new <Presenter> to display (and possibly edit) the aspect
	accessed by the <AspectAccessor> argument within the <CompositePresenter>
	argument."

	^self presenterBlock value: aCompositePresenter value: aValueModel!

printOn: aStream
	"Append a representation of the receiver to aStream."

	aStream
		basicPrint: self;
		nextPut: $(; print: self name; nextPut: $)!

putSelector
	^(self name copyWith: $:) asSymbol!

readFrom: anObject 
	^anObject perform: self getSelector!

value
	"Private - Answer the value of the receiver when it is to appear as an
	association (Aspects can be stored in Dictionaries)"

	^self!

writeInto: subjectObject value: valueObject
	"Private - Set the attribute of subjectObject described by the receiver 
	to valueObject."

	^subjectObject perform: self putSelector with: valueObject! !
!Aspect categoriesFor: #<=!comparing!public! !
!Aspect categoriesFor: #=!comparing!public! !
!Aspect categoriesFor: #accessorClass!constants!private! !
!Aspect categoriesFor: #accessorFor:!accessing!public! !
!Aspect categoriesFor: #beImmediateActionIsEdit!accessing!public! !
!Aspect categoriesFor: #bePresenterBlockReadOnly!accessing!public! !
!Aspect categoriesFor: #canEdit!public!testing! !
!Aspect categoriesFor: #canGenerateAccessors!private!testing! !
!Aspect categoriesFor: #canImmediateAction!public!testing! !
!Aspect categoriesFor: #canReadFrom:!private!testing! !
!Aspect categoriesFor: #canWriteInto:!private!testing! !
!Aspect categoriesFor: #category!public! !
!Aspect categoriesFor: #category:!public! !
!Aspect categoriesFor: #defaultFlags!initializing!private! !
!Aspect categoriesFor: #displayAspectInfoOf:on:!displaying!private! !
!Aspect categoriesFor: #displayAspectNameOf:on:!displaying!private! !
!Aspect categoriesFor: #displayAspectText:on:!displaying!private! !
!Aspect categoriesFor: #displayAspectValueOf:on:!displaying!private! !
!Aspect categoriesFor: #displayOn:!displaying!public! !
!Aspect categoriesFor: #editablePresenterBlock!enquiries!public! !
!Aspect categoriesFor: #editablePresenterFor:in:!enquiries!public! !
!Aspect categoriesFor: #editBlock!accessing!private! !
!Aspect categoriesFor: #getSelector!accessing!private! !
!Aspect categoriesFor: #hash!comparing!public! !
!Aspect categoriesFor: #immediateActionBlock!accessing!private! !
!Aspect categoriesFor: #isDefaultPresenterBlock!public!testing! !
!Aspect categoriesFor: #isPresenterBlockReadOnly!accessing!public! !
!Aspect categoriesFor: #key!accessing!private! !
!Aspect categoriesFor: #name!accessing!public! !
!Aspect categoriesFor: #name:presenterBlock:editBlock:!initializing!private! !
!Aspect categoriesFor: #nameIn:!accessing!private! !
!Aspect categoriesFor: #objectRefName:!helpers!private! !
!Aspect categoriesFor: #presenterBlock!accessing!public! !
!Aspect categoriesFor: #presenterFor:in:!enquiries!public! !
!Aspect categoriesFor: #printOn:!printing!public! !
!Aspect categoriesFor: #putSelector!accessing!private! !
!Aspect categoriesFor: #readFrom:!indirect accessing!private! !
!Aspect categoriesFor: #value!accessing!private! !
!Aspect categoriesFor: #writeInto:value:!indirect accessing!private! !

!Aspect class methodsFor!

autostring: aStringAspectSymbol 
	"Answer an instance of the receiver for aStringAspectSymbol.
	The aspect is editable using a TextPresenter with a single line editor view
	that updates on each character"

	^self name: aStringAspectSymbol
		presenterBlock: 
			[:p :m | 
			| presenter |
			presenter := TextPresenter createIn: p on: m.
			(presenter view)
				updatePerChar: true;
				selectAllIfSingleLine.
			presenter]!

bitmap: aBitmapAspectSymbol 
	"Answer an instance of the receiver for aBitmapAspectSymbol.
	The aspect is viewable using an ImagePresenter with a 'Basic image' view
	and editable using a FileDialog"

	^(self 
		name: aBitmapAspectSymbol
		presenterBlock: 
			[:p :m | 
			ImagePresenter 
				create: 'Basic image'
				in: p
				on: m]
		editBlock: 
			[:p | 
			| filename |
			filename := (FileOpenDialog new)
						fileTypes: (Array with: DIBSection filesType with: FileDialog allFilesType);
						showModal.
			filename notNil ifTrue: [p value: (DIBSection fromFile: filename)]])
		bePresenterBlockReadOnly;
		yourself!

block: anAspectSymbol 
	"Answer an instance of the receiver for anAspectSymbol, which is the accessor
	for some kind of <valuable> (not necessarily a block).
	The aspect is editable using a <ValueWorkspace> presenter."

	^self name: anAspectSymbol presenterBlock: [:p :m | ValueWorkspace createIn: p on: m]!

boolean: aBooleanAspectSymbol 
	"Answer an instance of the receiver for aBooleanAspectSymbol. The aspect is viewable using a
	<BooleanPresenter> and can be edited by toggling the aspect value. By default boolean aspects
	are not nullable. If they are nullable then a three state view is used."

	| answer |
	answer := super new.
	answer 
		name: aBooleanAspectSymbol
		presenterBlock: 
			[:p :m | 
			| bp |
			bp := BooleanPresenter 
						create: (answer isNullable 
								ifTrue: [BooleanPresenter threeStateView]
								ifFalse: [BooleanPresenter defaultView])
						in: p
						on: m.
			bp]
		editBlock: 
			[:p | 
			"3-state toggles between nil, false, and true in a cylce, 2-state just
			between cycles between false and true"
			p value: (answer isNullable 
						ifTrue: [p value ifNil: [false] ifNotNil: [:value | value ifFalse: [true]]]
						ifFalse: [p value not])].
	answer
		isNullable: false;
		beImmediateActionIsEdit.
	^answer!

choice: aChoiceAspectSymbol evaluationFrom: anArrayOfEvaluableStrings 
	"Answer an instance of the receiver for aChoiceAspectSymbol.
	The possible choices can be taken from evaluations of the strings in anArrayOfEvaluableStrings"

	^(self name: aChoiceAspectSymbol
		presenterBlock: 
			[:p :m | 
			| evaluatorModel |
			evaluatorModel := ValueConverter subject: m typeConverter: EvaluationConverter new inverted.
			(ChoicePresenter createIn: p on: evaluatorModel)
				choices: anArrayOfEvaluableStrings;
				yourself])
		isNullable: false;
		yourself!

choice: aChoiceAspectSymbol from: anArray
	"Answer an instance of the receiver for aChoiceAspectSymbol.
	The possible choices can be taken from from anArray"

	^(self name: aChoiceAspectSymbol
		presenterBlock: 
			[:p :m | 
			(ChoicePresenter createIn: p on: m)
				choices: anArray;
				yourself])
		isNullable: false;
		yourself!

choice: aChoiceAspectSymbol from: anArray andNil: nilChoice 
	"Answer an instance of the receiver for aChoiceAspectSymbol.
	The possible choices can be taken from from anArray together with a choice
	which represents nil"

	| choices |
	choices := (OrderedCollection with: nilChoice)
				addAll: anArray;
				yourself.
	^self name: aChoiceAspectSymbol
		presenterBlock: 
			[:p :m | 
			(ChoicePresenter createIn: p on: m)
				nilChoice: nilChoice;
				choices: choices;
				yourself]!

choice: aSymbol fromMap: aLookupTable nullValue: anObject 
	"Answer an instance of the receiver for an aspect named by the
	<Symbol> argument. The possible choices can be taken from 
	the <LookupTable> argument, whose keys are the display values, 
	for user presentation, and whose values are the actual value choices for 
	the aspect."

	^self name: aSymbol
		presenterBlock: 
			[:parent :model | 
			(ChoicePresenter createIn: parent
				on: (ValueConverter subject: model
						typeConverter: ((MappingConverter rightToLeft: aLookupTable)
								leftNullValue: anObject;
								yourself)))
				choices: aLookupTable keys asSortedCollection;
				yourself]!

collection: aSymbol 
	"Answer an instance of the receiver for aCollectionAspectSymbol .
	The aspect is displayed using a CollectionPresenter"

	^self collection: aSymbol presenterClass: CollectionPresenter!

collection: aSymbol addEvaluationFrom: anArrayOfStrings
	"Answer an instance of the receiver for aCollectionAspectSymbol.
	The aspect is displayed using a CollectionPresenter and may have new items added
	by choosing an appropriate evaluation from anArrayOfStrings"

	^self 
		collection: aSymbol
		presenterClass: CollectionPresenter
		addEvaluationFrom: anArrayOfStrings!

collection: aCollectionAspectSymbol addFrom: anArray
	"Answer an instance of the receiver for aCollectionAspectSymbol.
	The aspect is displayed using a CollectionPresenter and may have new items added
	by choosing an appropriate object from anArray"

	^self 
		collection: aCollectionAspectSymbol
		presenterClass: CollectionPresenter
		addFrom: anArray!

collection: aSymbol presenterClass: aClass 
	^self 
		name: aSymbol
		presenterBlock: [:p :m | aClass createIn: p on: m]
		editBlock: self defaultCollectionEditBlock!

collection: aSymbol presenterClass: collectionPresenterClass addEvaluationFrom: anArrayOfStrings 
	^self 
		name: aSymbol
		presenterBlock: 
			[:p :m | 
			(collectionPresenterClass createIn: p on: m) setAddItemBlock: 
					[| choice |
					choice := anArrayOfStrings size > 1 
								ifTrue: [ChoicePrompter choices: anArrayOfStrings caption: 'Add an Evaluation']
								ifFalse: [anArrayOfStrings first].
					choice notNil ifTrue: [Compiler evaluate: choice logged: false]]]
		editBlock: self defaultCollectionEditBlock!

collection: aCollectionAspectSymbol presenterClass: collectionPresenterClass addFrom: anArray 
	^self 
		name: aCollectionAspectSymbol
		presenterBlock: 
			[:p :m | 
			(collectionPresenterClass createIn: p on: m) setAddItemBlock: 
					[anArray size > 1 
						ifTrue: [ChoicePrompter choices: anArray caption: 'Add ...']
						ifFalse: [anArray first]]]
		editBlock: self defaultCollectionEditBlock!

color: aColorAspectSymbol 
	"Answer an instance of the receiver for aColorAspectSymbol.
	The aspect is viewable  using a ColorPresenter and editable using a ColorDialog"

	^(self 
		name: aColorAspectSymbol
		presenterBlock: [:p :m | ColorPresenter createIn: p on: m]
		editBlock: [:p | ColorDialog showModalOn: p model])
		beImmutable;
		bePresenterBlockReadOnly;
		yourself!

date: aSymbol 
	"Answer an instance of the receiver for accessing a <Date> aspect
	of an object with accessor, aSymbol.
	The aspect is viewable and editable using a DatePresenter."

	^self name: aSymbol presenterBlock: [:p :m | DatePresenter createIn: p on: m]!

defaultCollectionEditBlock
	^nil.
	^[:each | ]!

defaultPresenterBlock
	"Private - Answers a valuable suitable for displaying an aspect in a
	<ValueWorkspace>."

	^[:p :m | ValueWorkspace createIn: p on: m]!

dictionary: aSymbol
	"Answer an instance of the receiver for the <Dictionary> aspect named by the <Symbol> 
	argument . The aspect is displayed using a DictionaryPresenter"

	^self collection: aSymbol presenterClass: DictionaryPresenter!

fileOpen: aFilenameAspectSymbol 
	"Answer an instance of the receiver for aFilenameAspectSymbol.
	The aspect is viewable using a ValueWorkspace and editable using a FileSaveDialog"

	^self name: aFilenameAspectSymbol editBlock: [:p | FileOpenDialog showModalOn: p model]!

fileSave: aFilenameAspectSymbol 
	"Answer an instance of the receiver for aFilenameAspectSymbol.
	The aspect is viewable using a ValueWorkspace and editable using a FileSaveDialog"

	^self name: aFilenameAspectSymbol editBlock: [:p | FileSaveDialog showModalOn: p model]!

float: aSymbol
	"Answer an instance of the receiver for the <Float> aspect, aSymbol.
	The aspect is editable using a NumberPresenter."

	^self number: aSymbol!

folder: aFolderAspectSymbol 
	"Answer an instance of the receiver for aFolderAspectSymbol.
	The aspect is viewable using a ValueWorkspace and editable using a BrowseFolderDialog"

	^self name: aFolderAspectSymbol
		editBlock: (Smalltalk at: #BrowseFolderDialog
				ifPresent: [:dialog | [:p | dialog showModalOn: p model]])!

font: aFontAspectSymbol 
	"Answer an instance of the receiver for aFontAspectSymbol.
	The aspect is viewable using a FontPresenter and editable using a FontDialog"

	^(self 
		name: aFontAspectSymbol
		presenterBlock: [:p :m | FontPresenter createIn: p on: m]
		editBlock: [:p | FontDialog showModalOn: p model])
		bePresenterBlockReadOnly;
		yourself!

hotkey: aHotKeyAspectSymbol 
	"Answer an instance of the receiver for aHotKeyAspectSymbol.
	The aspect is editable using a HotKey control."

	^self name: aHotKeyAspectSymbol presenterBlock: [:p :m | AcceleratorPresenter createIn: p on: m]!

icon: anIconAspectSymbol 
	"Answer an instance of the receiver for anIconAspectSymbol.
	The aspect is viewable using an ImagePresenter with a 'Basic image' view
	and editable using a FileDialog"

	^(self 
		name: anIconAspectSymbol
		presenterBlock: 
			[:p :m | 
			| ip |
			ip := ImagePresenter 
						create: 'Basic image'
						in: p
						on: m.
			ip view isWholeBackgroundErased: true.
			ip]
		editBlock: [:p | InternalIcon choose ifNotNil: [:icon | p value: icon]])
		bePresenterBlockReadOnly;
		yourself!

imageList: anImageListAspectSymbol 
	^self name: anImageListAspectSymbol
		presenterBlock: 
			[:p :m | 
			ImagePresenter 
				create: 'ImageList view'
				in: p
				on: m]!

inspector: anAspectSymbol
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect is editable using an appropriate inspector"

	^self name: anAspectSymbol
		presenterBlock: 
			[:p :m | 
			(m inspectorClass createIn: p)
				object: m;
				yourself]!

integer: aSymbol
	"Answer an instance of the receiver for aSymbol.
	The aspect is editable using a NumberPresenter"

	^self number: aSymbol!

key: aKey
	"Answers an instance of KeyedAspect on aKey"

	^KeyedAspect key: aKey!

list: aListAspectSymbol
	"Answer an instance of the receiver for aListAspectSymbol.
	The aspect is displayed using a CollectionPresenter"

	#deprecated. "Use #collection:"

	^self collection: aListAspectSymbol
!

list: aListAspectSymbol addEvaluationFrom: anArrayOfStrings
	#deprecated.
	^self sequenceableCollection: aListAspectSymbol addEvaluationFrom: anArrayOfStrings!

list: aListAspectSymbol addFrom: anArray
	#deprecated.
	^self sequenceableCollection: aListAspectSymbol addFrom: anArray!

maxDisplayCharacters
	^40!

menu: aMenuAspectSymbol 
	"Answer an instance of the receiver for aMenuAspectSymbol.
	The aspect is editable using a MenuComposer"

	^self name: aMenuAspectSymbol editBlock: [:p | MenuComposer showModalOn: p model]!

menuBar: aMenuAspectSymbol 
	"Answer an instance of the receiver for aMenuAspectSymbol.
	The aspect is editable using a MenuComposer"

	^self name: aMenuAspectSymbol editBlock: [:p | MenuBarComposer showModalOn: p model]!

multilineString: aStringAspectSymbol
	"Answer an instance of the receiver for aStringAspectSymbol.
	The aspect is editable using a TextPresenter with a multiline editor view
	that updates on each character"

	^self name: aStringAspectSymbol
		presenterBlock: 
			[:p :m | 
			| presenter |
			presenter := TextPresenter 
						create: 'Multiline text'
						in: p
						on: m.
			presenter view updatePerChar: true.
			presenter]!

name: aSymbol
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect is editable using the default ValueWorkspace presenter"

	^self name: aSymbol presenterBlock: self defaultPresenterBlock!

name: aSymbol chooseFrom: anArrayOEvaluableStrings 
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect is editable using a choice presenter fdialog filled with potential evaluations
	listed in anArrayOfStrings"

	"^self choice: aSymbol evaluationFrom: anArrayOEvaluableStrings."

	"Old code follows"

	^self name: aSymbol
		editBlock: 
			[:p | 
			| choice |
			choice := ChoicePrompter choices: anArrayOEvaluableStrings caption: 'Set ' , aSymbol , ' to:'.
			choice notNil ifTrue: [p value: (Compiler evaluate: choice logged: false)]]!

name: aSymbol editBlock: aOneArgEditBlock 
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect is editable using the default ValueWorkspace presenter and may be additionally
	edited by evaluating aOneArgEditBlock whose parameter is the presenter viewing
	the aspect. Note that ValueWorkspace is a development class and this is therefore a
	development method."

	^self 
		name: aSymbol
		presenterBlock: self defaultPresenterBlock
		editBlock: aOneArgEditBlock!

name: aSymbol presenterBlock: aTwoArgPresenterBlock
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect is editable using the presenter answered by aTwoArgOPresenterBlock
	the first parameter to which is the parent presenter to host the editor and the
	second is the model being edited."

	^self 
		name: aSymbol
		presenterBlock: aTwoArgPresenterBlock
		editBlock: nil!

name: aSymbol presenterBlock: aTwoArgPresenterBlock editBlock: aOneArgEditBlock
	"Answer an instance of the receiver for anAspectSymbol.
	The aspect will be made visible using the presenter answered by aTwoArgPresenterBlock
	the first parameter to which is the parent presenter to host it and the second is the model
	being edited. The aspect may be additionally edited by evaluating aOneArgEditBlock
	whose parameter is the presenter viewing the aspect."

	^super new 
		name: aSymbol
		presenterBlock: aTwoArgPresenterBlock
		editBlock: aOneArgEditBlock!

new
	"Private - Use #name:presenterClass:"

	^self shouldNotImplement!

number: aSymbol 
	"Answer an instance of the receiver for the <Number> aspect, aSymbol.
	The aspect is editable using a NumberPresenter."

	^self name: aSymbol
		presenterBlock: 
			[:p :m | 
			| presenter |
			presenter := NumberPresenter createIn: p on: m.
			presenter view typeconverter leftNullValue: 0.
			presenter view selectAllIfSingleLine.
			presenter]!

richText: aRichTextAspectSymbol
	"Answer an instance of the receiver for aTextAspectSymbol.
	The aspect is editable using a RichTextPresenter"

	^self name: aRichTextAspectSymbol
		presenterBlock: 
			[:p :m | 
			| presenter |
			presenter := RichTextPresenter createIn: p on: m.
			presenter view updatePerChar: true.
			presenter]!

sequenceableCollection: aSymbol
	"Answer an instance of the receiver for the <SequenceableCollection> aspect named
	by the <Symbol> argument."

	^self collection: aSymbol presenterClass: SequenceableCollectionPresenter!

sequenceableCollection: aSymbol addEvaluationFrom: anArray
	"Answer an instance of the receiver for an aspect named by the <Symbol>, aSymbol.
	The aspect is displayed using a SequenceableCollectionPresenter and may have new 
	items added by choosing an appropriate appropriate evaluation from the <Array>
	of <String>s, anArray."

	^self 
		collection: aSymbol
		presenterClass: SequenceableCollectionPresenter
		addEvaluationFrom: anArray!

sequenceableCollection: aSymbol addFrom: anArray
	"Answer an instance of the receiver for an aspect named by the <Symbol>, aSymbol.
	The aspect is displayed using a SequenceableCollectionPresenter and may have new 
	items added by choosing an appropriate object from the <Array>, anArray."

	^self 
		collection: aSymbol
		presenterClass: SequenceableCollectionPresenter
		addFrom: anArray!

set: aSymbol
	"Answer an instance of the receiver for the <Set> aspect named by the <Symbol> 
	argument . The aspect is displayed using a HashedCollectionPresenter"

	^self collection: aSymbol presenterClass: HashedCollectionPresenter!

string: aStringAspectSymbol 
	"Answer an instance of the receiver for aStringAspectSymbol.
	The aspect is editable using a TextPresenter with a single editor view
	that updates on Enter or kill focus"

	^self name: aStringAspectSymbol
		presenterBlock: 
			[:p :m | 
			| presenter |
			presenter := TextPresenter createIn: p on: m.
			presenter view selectAllIfSingleLine.
			presenter]!

time: aSymbol 
	"Answer an instance of the receiver for accessing a <Time> aspect
	of an object with accessor, aSymbol.
	The aspect is viewable and editable using a TimePresenter."

	^self name: aSymbol presenterBlock: [:p :m | TimePresenter createIn: p on: m]! !
!Aspect class categoriesFor: #autostring:!instance creation!public! !
!Aspect class categoriesFor: #bitmap:!instance creation!public! !
!Aspect class categoriesFor: #block:!development!instance creation!public! !
!Aspect class categoriesFor: #boolean:!instance creation!public! !
!Aspect class categoriesFor: #choice:evaluationFrom:!instance creation!public! !
!Aspect class categoriesFor: #choice:from:!instance creation!public! !
!Aspect class categoriesFor: #choice:from:andNil:!instance creation!public! !
!Aspect class categoriesFor: #choice:fromMap:nullValue:!instance creation!public! !
!Aspect class categoriesFor: #collection:!instance creation!public! !
!Aspect class categoriesFor: #collection:addEvaluationFrom:!instance creation!public! !
!Aspect class categoriesFor: #collection:addFrom:!instance creation!public! !
!Aspect class categoriesFor: #collection:presenterClass:!instance creation!private! !
!Aspect class categoriesFor: #collection:presenterClass:addEvaluationFrom:!instance creation!private! !
!Aspect class categoriesFor: #collection:presenterClass:addFrom:!instance creation!private! !
!Aspect class categoriesFor: #color:!instance creation!public! !
!Aspect class categoriesFor: #date:!instance creation!public! !
!Aspect class categoriesFor: #defaultCollectionEditBlock!constants!private! !
!Aspect class categoriesFor: #defaultPresenterBlock!constants!development!private! !
!Aspect class categoriesFor: #dictionary:!instance creation!public! !
!Aspect class categoriesFor: #fileOpen:!instance creation!public! !
!Aspect class categoriesFor: #fileSave:!instance creation!public! !
!Aspect class categoriesFor: #float:!instance creation!public! !
!Aspect class categoriesFor: #folder:!instance creation!public! !
!Aspect class categoriesFor: #font:!instance creation!public! !
!Aspect class categoriesFor: #hotkey:!instance creation!public! !
!Aspect class categoriesFor: #icon:!instance creation!public! !
!Aspect class categoriesFor: #imageList:!instance creation!public! !
!Aspect class categoriesFor: #inspector:!instance creation!public! !
!Aspect class categoriesFor: #integer:!instance creation!public! !
!Aspect class categoriesFor: #key:!instance creation!public! !
!Aspect class categoriesFor: #list:!instance creation!public! !
!Aspect class categoriesFor: #list:addEvaluationFrom:!instance creation!public! !
!Aspect class categoriesFor: #list:addFrom:!instance creation!public! !
!Aspect class categoriesFor: #maxDisplayCharacters!constants!public! !
!Aspect class categoriesFor: #menu:!instance creation!must strip!public! !
!Aspect class categoriesFor: #menuBar:!instance creation!must strip!public! !
!Aspect class categoriesFor: #multilineString:!instance creation!public! !
!Aspect class categoriesFor: #name:!development!instance creation!public! !
!Aspect class categoriesFor: #name:chooseFrom:!development!instance creation!public! !
!Aspect class categoriesFor: #name:editBlock:!development!instance creation!public! !
!Aspect class categoriesFor: #name:presenterBlock:!instance creation!public! !
!Aspect class categoriesFor: #name:presenterBlock:editBlock:!instance creation!public! !
!Aspect class categoriesFor: #new!instance creation!private! !
!Aspect class categoriesFor: #number:!instance creation!public! !
!Aspect class categoriesFor: #richText:!instance creation!public! !
!Aspect class categoriesFor: #sequenceableCollection:!instance creation!public! !
!Aspect class categoriesFor: #sequenceableCollection:addEvaluationFrom:!instance creation!public! !
!Aspect class categoriesFor: #sequenceableCollection:addFrom:!instance creation!public! !
!Aspect class categoriesFor: #set:!instance creation!public! !
!Aspect class categoriesFor: #string:!instance creation!public! !
!Aspect class categoriesFor: #time:!instance creation!public! !

