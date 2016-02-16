"Filed out from Dolphin Smalltalk 7"!

Shell subclass: #PlimboleShell
	instanceVariableNames: 'plimbolePresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PlimboleShell guid: (GUID fromString: '{460ACFFF-A9A4-4A8B-872D-2B0674D4CFD1}')!
PlimboleShell comment: 'This is the Shell Presenter class for the Plimbole Generative Music Sequencer. It is really only here to supply an associated view that contains UI buttons to send command to the embedded PlimbolePresenter. This is the entry point to the use of Plimbole as a standaline application. Try this:

PlimboleShell show'!
!PlimboleShell categoriesForClass!MVP-Presenters! !
!PlimboleShell methodsFor!

addToCommandRoute: route 
	"Private - Update the <OrderedCollection>, path, with the receiver's contribution to the command path
	held by the <CommandPolicy>, route. Answer the next <Presenter> to visit. Here we add our
	Plimbole subcomponent so it will receive the UI commands"

	plimbolePresenter addToCommandRoute: route.
	^super addToCommandRoute: route!

createComponents
	super createComponents.
	plimbolePresenter := self add: PlimbolePresenter new name: 'plimbole'!

model: aPlimbole 
	super model: aPlimbole.
	plimbolePresenter model: aPlimbole.
	aPlimbole
		when: #playNote:forCell:
			send: #onPlayNote:forCell:
			to: self;
		when: #playStarted
			send: #onPlayStarted
			to: self!

onPlayNote: note forCell: aPlimboleCell
	"self view backcolor: aPlimboleCell color"!

onPlayStarted
	| random index palette |
	random := Random new.
	random next.
	palette := plimbolePresenter palette allButLast.
	index := (random next * palette size) truncated + 1.
	self view backcolor: (RGB fromHTMLSpec: (palette at: index))! !
!PlimboleShell categoriesFor: #addToCommandRoute:!private! !
!PlimboleShell categoriesFor: #createComponents!initializing!private! !
!PlimboleShell categoriesFor: #model:!public! !
!PlimboleShell categoriesFor: #onPlayNote:forCell:!initializing!private! !
!PlimboleShell categoriesFor: #onPlayStarted!private! !

!PlimboleShell class methodsFor!

defaultModel
	^Plimbole new!

displayOn: aStream
	"Append, to aStream, a String whose characters are a representation of the receiver as a user
	would want to see it."

	aStream nextPutAll: 'Plimbole'!

icon
	^PlimbolePresenter icon!

initialize
	"Private - Initialize the receiver's class variables
		self initialize
	"

	Smalltalk developmentSystem 
		addSamplesFolderIconFor: self
		description: self displayString!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 3 788558 10 ##(Smalltalk.STBViewProxy) 8 ##(Smalltalk.ShellView) 98 27 0 0 98 2 26476545 131073 416 0 196934 1 ##(Smalltalk.RGB) 13671417 328198 ##(Smalltalk.Point) 973 1029 39 0 0 0 416 788230 ##(Smalltalk.BorderLayout) 1 1 410 8 ##(Smalltalk.ContainerView) 98 15 0 416 98 2 8 1140850688 131073 576 0 0 0 7 0 0 0 576 0 234 256 98 0 0 983302 ##(Smalltalk.MessageSequence) 202 208 98 1 721670 ##(Smalltalk.MessageSend) 8 #createAt:extent: 98 2 514 1 1 514 1001 101 576 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 244 1 0 0 50 0 0 0] 98 6 410 8 ##(Smalltalk.ToolButton) 98 14 0 576 98 2 8 1140850688 131073 912 0 0 0 7 0 0 0 912 0 410 8 ##(Smalltalk.Toolbar) 98 25 0 912 98 2 8 1140853580 131137 992 0 0 514 101 101 515 0 0 0 992 0 8 4294905523 0 234 256 98 2 9091 1115910 ##(Smalltalk.ToolbarIconButton) 9091 0 992 1 1180998 4 ##(Smalltalk.CommandDescription) 8 #fasterTempo 8 'Faster Tempo' 1 1 786694 ##(Smalltalk.InternalIcon) 852742 ##(Smalltalk.GdiplusBitmap) 0 16 2097670 ##(Smalltalk.GdiplusImageFromBytesInitializer) 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 0 248 73 68 65 84 104 67 237 217 193 138 194 64 20 5 209 172 253 127 112 147 159 20 92 39 190 135 133 32 55 139 136 16 43 210 7 132 161 47 33 37 204 64 195 76 195 48 12 255 103 93 215 203 178 44 215 250 220 248 92 251 140 217 175 130 231 10 126 211 103 204 126 21 123 167 251 165 207 152 253 104 14 204 126 244 6 102 63 122 3 179 31 189 129 217 143 222 192 236 71 111 96 246 163 55 48 251 209 27 152 253 232 13 204 126 244 6 102 63 122 3 179 31 189 129 249 24 245 190 190 18 207 91 23 179 163 244 187 187 161 126 252 252 42 94 15 246 29 94 161 91 200 218 175 30 186 241 252 207 117 11 89 251 253 195 23 56 247 175 80 61 119 238 63 226 111 60 95 159 152 253 232 13 204 126 244 6 102 63 122 3 179 31 189 129 217 143 222 192 236 71 111 96 246 163 55 48 251 209 27 152 253 232 13 204 126 244 6 102 63 122 3 179 223 214 5 176 207 152 253 184 65 190 233 51 102 191 234 61 247 191 152 134 97 24 118 154 166 7 3 3 27 3 56 224 128 78 0 0 0 0 73 69 78 68 174 66 96 130] 395334 3 ##(Smalltalk.Bitmap) 0 16 0 0 0 0 3 514 81 81 1 98 1 1152 234 240 98 2 1360 1 0 1 0 514 81 81 514 91 91 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 992 754 8 #updateSizePosted 672 992 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 514 193 193 0 27 690 202 208 98 3 754 784 98 2 514 511 1 514 101 101 912 754 8 #isEnabled: 98 1 32 912 754 8 #text: 98 1 8 'FasterTempo' 912 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 49 1 0 0 50 0 0 0] 98 1 992 1664 0 27 410 928 98 14 0 576 98 2 8 1140850688 131073 1952 0 0 0 7 0 0 0 1952 0 410 1008 98 25 0 1952 98 2 8 1140853580 131137 2016 0 0 514 101 101 515 0 0 0 2016 0 8 4294905523 0 234 256 98 2 9093 1138 9093 0 2016 1 1170 8 #slowerTempo 8 'Slower Tempo' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 0 90 73 68 65 84 104 67 237 211 49 10 192 32 16 4 64 123 255 223 4 242 201 144 90 115 194 61 192 206 40 51 112 229 234 10 103 1 0 0 0 14 211 90 171 49 119 204 219 23 25 119 103 135 154 181 230 69 232 202 115 150 27 93 178 214 188 8 61 153 95 110 116 201 90 243 78 120 192 246 43 180 247 39 6 0 0 0 254 172 148 15 97 229 85 70 183 92 14 228 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 61 61 1 98 1 2144 234 240 98 2 2272 1 0 1 0 514 61 61 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 2016 754 1600 672 2016 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 401 1 514 101 101 1952 754 1808 98 1 32 1952 754 1856 98 1 8 'Slower Tempo' 1952 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 200 0 0 0 0 0 0 0 250 0 0 0 50 0 0 0] 98 1 2016 1664 0 27 410 928 98 14 0 576 98 2 8 1140850688 131073 2800 0 0 0 7 0 0 0 2800 0 410 1008 98 25 0 2800 98 2 8 1140853580 131137 2864 0 0 514 101 101 515 0 0 0 2864 0 8 4294905523 0 234 256 98 2 9095 1138 9095 0 2864 1 1170 8 #nextTenorVoice 8 'Next Tenor Voice' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 1 135 73 68 65 84 104 67 237 153 189 74 3 81 20 132 83 72 170 116 226 95 35 190 130 77 80 95 66 16 226 51 8 54 54 22 26 171 52 190 129 173 34 118 118 218 91 168 133 133 141 22 150 166 181 82 16 4 17 220 248 157 221 81 98 226 6 22 132 115 149 243 193 176 231 102 103 47 51 73 54 4 182 22 4 9 146 101 217 20 58 66 207 146 205 147 58 157 54 189 94 175 78 216 27 142 223 208 107 117 217 210 133 160 171 69 228 31 105 201 150 46 20 216 81 216 33 56 215 150 45 93 200 217 42 226 14 99 159 142 108 233 66 206 178 123 224 150 67 250 247 128 65 216 9 116 136 30 209 19 250 27 191 66 188 195 211 4 109 162 5 105 73 250 92 55 205 35 123 58 16 108 6 157 162 119 251 186 140 194 60 232 132 49 141 34 4 105 16 232 46 79 87 1 93 211 208 54 126 16 100 187 136 84 29 174 221 210 54 126 16 226 74 121 42 99 215 106 27 63 8 209 85 158 202 112 237 189 182 241 163 191 0 115 71 99 41 120 246 52 218 220 213 54 126 12 20 216 208 88 10 158 93 141 81 224 87 136 2 222 68 1 111 162 128 55 255 161 192 133 194 60 160 245 60 217 8 240 108 162 23 205 231 218 198 15 114 204 17 164 141 230 209 154 5 235 227 90 250 194 60 104 17 217 191 216 89 109 147 6 131 5 88 239 155 180 204 49 143 236 233 17 5 188 137 2 222 68 1 111 162 128 55 81 192 155 40 224 77 20 240 134 112 43 202 153 195 186 99 210 50 135 245 178 236 233 65 62 123 62 118 140 222 208 25 26 71 246 184 233 18 189 114 254 0 141 201 30 4 254 212 106 31 79 218 122 19 5 66 172 252 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 2992 234 240 98 2 3120 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 2864 754 1600 672 2864 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 91 1 514 101 101 2800 754 1808 98 1 32 2800 754 1856 98 1 8 'Next Tenor Voice' 2800 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 45 0 0 0 0 0 0 0 95 0 0 0 50 0 0 0] 98 1 2864 1664 0 27 410 928 98 14 0 576 98 2 8 1140850688 131073 3648 0 0 0 7 0 0 0 3648 0 410 1008 98 25 0 3648 98 2 8 1140853580 131137 3712 0 0 514 101 101 515 0 0 0 3712 0 8 4294905523 0 234 256 98 2 9097 1138 9097 0 3712 1 1170 8 #previousTenorVoice 8 'Previous Tenor Voice' 1 1 1234 1266 0 16 1298 0 3104 1346 0 16 0 0 0 0 3 514 71 71 1 98 1 3840 234 240 98 2 3952 1 0 1 0 514 71 71 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 3712 754 1600 672 3712 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 1 514 101 101 3648 754 1808 98 1 32 3648 754 1856 98 1 8 'PreviousTenor Voice' 3648 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 1 3712 1664 0 27 410 928 98 14 0 576 98 2 8 1140850688 131073 4480 0 0 0 7 0 0 0 4480 0 410 1008 98 25 0 4480 98 2 8 1140853580 131137 4544 0 0 514 101 101 515 0 0 0 4544 0 8 4294905523 0 234 256 98 2 9099 1138 9099 0 4544 1 1170 8 #nextAltoVoice 8 'Next Alto Voice' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 2 125 73 68 65 84 104 67 237 152 207 139 77 97 24 199 239 157 133 5 74 77 225 15 176 81 152 153 37 217 41 81 147 44 88 224 46 200 214 130 26 11 101 35 210 172 148 133 162 137 228 15 80 102 33 165 41 101 74 74 22 86 138 40 99 225 71 141 148 95 83 184 215 231 123 206 23 233 206 189 115 102 115 159 39 157 79 125 123 223 231 190 207 251 158 207 153 58 247 199 52 106 106 18 210 110 183 135 201 13 242 217 209 124 216 203 185 233 116 58 67 200 62 96 252 7 191 54 228 182 188 32 186 171 84 238 70 107 110 203 11 146 199 236 219 133 214 220 150 23 36 119 218 183 11 173 185 45 47 120 234 25 184 95 42 255 197 175 229 127 6 4 162 107 16 158 34 243 206 148 94 243 114 110 16 93 129 240 8 217 74 182 57 154 143 106 205 109 57 65 242 48 121 135 232 162 176 246 134 28 116 123 46 16 59 106 207 190 208 39 14 121 91 14 16 90 69 62 216 113 73 232 157 103 88 237 237 241 32 180 183 84 171 14 123 246 123 123 60 200 92 182 215 239 183 203 69 97 237 174 167 154 95 245 246 88 112 105 34 243 210 82 175 72 191 79 226 3 228 133 231 115 12 77 31 19 7 18 27 37 36 144 186 70 110 186 236 194 235 87 92 170 222 236 99 226 64 226 132 125 36 212 34 61 31 102 214 230 200 62 151 170 79 250 152 56 144 184 99 153 31 100 188 48 235 3 61 219 201 119 207 103 124 76 12 56 172 68 226 139 101 30 145 211 154 247 131 158 227 164 248 189 192 248 141 33 238 237 20 129 221 18 17 204 207 147 123 46 123 66 207 109 134 51 101 85 212 123 124 220 224 225 226 23 237 33 145 113 178 224 178 39 244 124 34 59 92 170 190 228 227 6 15 23 127 106 9 73 85 254 48 163 87 191 25 62 122 254 220 199 13 30 46 254 213 18 211 228 130 230 85 160 119 146 20 111 183 140 11 62 110 240 112 113 61 144 179 120 140 49 62 145 80 21 232 125 204 160 61 15 201 132 143 139 3 137 245 164 93 234 45 13 173 63 201 90 111 143 7 153 150 221 42 195 158 60 95 169 145 185 110 175 202 104 143 183 199 130 139 190 204 233 139 217 178 96 207 107 134 92 95 230 150 11 55 177 201 199 196 129 196 8 46 250 100 45 66 61 35 57 193 124 86 113 169 250 22 195 159 94 50 230 99 242 128 212 41 82 128 176 222 239 39 93 138 35 110 203 11 146 245 13 132 130 100 125 3 161 32 89 223 64 40 72 214 55 16 10 146 245 13 132 130 240 132 101 117 3 103 201 57 151 170 91 110 203 11 146 27 136 254 3 247 150 108 33 163 228 61 121 70 214 185 45 55 252 177 155 138 203 162 246 180 230 63 163 209 248 5 30 183 69 244 73 136 6 21 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 4672 234 240 98 2 4800 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 4544 754 1600 672 4544 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 903 1 514 101 101 4480 754 1808 98 1 32 4480 754 1856 98 1 8 'Next Alto Voice' 4480 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 195 1 0 0 0 0 0 0 245 1 0 0 50 0 0 0] 98 1 4544 1664 0 27 410 928 98 14 0 576 98 2 8 1140850688 131073 5328 0 0 0 7 0 0 0 5328 0 410 1008 98 25 0 5328 98 2 8 1140853580 131137 5392 0 0 514 101 101 515 0 0 0 5392 0 8 4294905523 0 234 256 98 2 9101 1138 9101 0 5392 1 1170 8 #previousAltoVoice 8 'Previous Alto Voice' 1 1 1234 1266 0 16 1298 0 4784 1346 0 16 0 0 0 0 3 514 71 71 1 98 1 5520 234 240 98 2 5632 1 0 1 0 514 71 71 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 5392 754 1600 672 5392 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 811 1 514 101 101 5328 754 1808 98 1 32 5328 754 1856 98 1 8 'Previous Alto Voice' 5328 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 149 1 0 0 0 0 0 0 199 1 0 0 50 0 0 0] 98 1 5392 1664 0 27 1664 0 27 410 592 98 15 0 416 98 2 8 1140850688 131073 6160 0 0 0 7 0 0 0 6160 0 234 256 672 0 690 202 208 98 1 754 784 98 2 514 1 901 514 1001 101 6160 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 194 1 0 0 244 1 0 0 244 1 0 0] 98 3 410 928 98 14 0 6160 98 2 8 1140850688 131073 6400 0 0 0 7 0 0 0 6400 0 410 1008 98 25 0 6400 98 2 8 1140853580 131137 6464 0 0 514 101 101 515 0 0 0 6464 0 8 4294905523 0 234 256 98 2 9085 1138 9085 0 6464 1 1170 8 #clearAll 8 'Clear' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 3 39 73 68 65 84 104 67 237 152 59 104 84 65 20 134 55 24 162 133 143 40 40 130 69 154 32 18 77 103 33 136 41 196 70 73 161 105 180 210 52 166 210 34 248 40 98 161 118 177 81 80 180 138 149 157 133 104 103 101 154 104 101 108 180 8 26 16 196 152 42 96 225 91 220 245 59 103 254 27 152 220 205 205 234 206 102 21 238 7 195 204 249 103 206 127 230 100 239 62 72 165 164 164 164 228 255 166 86 171 117 84 171 213 139 140 57 214 13 193 217 247 150 195 178 67 54 237 131 139 140 234 82 198 28 227 237 10 99 222 206 27 172 71 101 211 62 184 196 172 46 115 76 210 138 112 246 132 114 102 37 181 15 46 241 213 46 3 13 63 14 118 214 18 44 87 82 251 200 26 80 216 48 101 3 141 64 129 203 86 168 205 92 209 117 254 156 178 129 52 252 125 3 6 77 108 96 76 201 108 213 160 230 83 166 77 186 70 115 96 54 22 108 87 15 106 94 82 249 230 193 111 36 216 174 42 35 42 223 60 252 53 134 100 90 143 67 58 243 74 177 67 188 248 17 105 107 201 14 241 27 233 7 36 229 96 111 200 147 83 128 217 128 124 115 176 231 63 33 152 159 73 114 136 139 26 152 150 126 68 82 14 246 6 60 57 5 152 245 201 55 7 123 167 116 230 177 36 135 184 168 129 73 233 254 155 168 30 236 245 121 114 10 48 219 42 223 28 236 157 181 51 44 239 7 37 128 94 212 192 35 211 89 46 251 222 226 204 54 79 78 1 126 93 24 254 8 214 49 232 99 118 134 121 66 146 67 92 212 192 61 233 231 37 69 160 91 173 46 79 78 5 166 11 193 62 199 184 246 175 43 118 136 139 26 184 45 253 170 164 8 244 5 79 76 9 166 51 242 143 64 191 163 253 232 50 196 203 54 0 89 211 55 20 71 160 207 120 98 74 48 173 251 109 140 158 61 14 231 36 57 196 69 175 64 246 216 221 149 20 129 62 229 137 41 193 244 161 252 35 76 215 254 105 73 14 113 81 3 103 76 103 25 189 241 51 50 207 164 96 26 189 73 51 208 159 104 255 184 36 135 184 168 129 147 210 163 143 222 12 244 9 79 76 9 190 227 193 62 199 115 219 167 232 97 197 142 93 218 19 193 214 146 51 142 74 143 190 252 50 208 175 121 98 74 48 93 238 35 239 181 246 247 75 114 136 139 94 129 131 210 163 159 31 25 232 23 60 49 37 248 14 7 251 24 138 205 219 62 115 191 36 135 184 168 129 189 210 223 73 90 202 176 39 166 132 98 131 50 143 64 255 204 100 255 220 234 9 74 128 184 168 129 157 166 179 252 24 148 24 246 7 61 49 37 152 238 147 127 4 250 79 166 117 140 205 46 8 187 180 82 115 13 192 118 70 39 250 247 16 198 88 45 165 166 3 211 94 249 231 96 111 11 99 45 195 154 113 88 215 109 128 245 47 166 245 204 27 25 213 160 198 32 247 42 53 29 248 118 7 251 60 20 236 177 51 204 159 36 21 53 240 141 105 13 243 142 160 212 165 91 169 233 192 212 94 242 165 143 130 131 222 111 103 152 63 72 42 106 192 127 231 176 220 21 148 24 157 237 244 196 212 96 190 248 143 217 86 97 53 84 46 61 152 191 84 157 150 97 53 84 46 61 152 79 170 78 203 176 26 42 151 30 204 31 168 78 203 176 26 42 151 30 204 111 170 78 203 160 198 45 149 75 15 230 187 25 211 140 47 170 151 12 243 100 188 96 236 81 185 146 146 146 146 127 158 74 229 55 255 4 229 156 56 162 117 62 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 6592 234 240 98 2 6720 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 6464 754 1600 672 6464 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 1 514 101 101 6400 754 1808 98 1 32 6400 754 1856 98 1 8 'Clear' 6400 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 1 6464 1664 0 27 410 928 98 14 0 6160 98 2 8 1140850688 131073 7248 0 0 0 7 0 0 0 7248 0 410 1008 98 25 0 7248 98 2 8 1140853580 131137 7312 0 0 514 101 101 515 0 0 0 7312 0 8 4294905523 0 234 256 98 2 9087 1138 9087 0 7312 1 1170 8 #play 8 'Play' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 1 137 73 68 65 84 104 67 237 153 189 74 3 65 20 133 215 159 90 132 8 130 143 144 198 198 198 202 167 72 101 210 88 89 89 249 18 130 149 54 86 118 190 69 26 109 108 108 44 197 218 128 160 4 44 253 217 205 55 206 65 16 68 141 59 51 153 43 243 193 129 187 108 246 222 115 96 147 204 206 86 133 66 161 144 63 117 93 247 209 24 221 54 77 211 67 115 58 101 3 140 63 98 250 3 142 135 168 171 211 249 35 223 159 32 192 51 58 68 75 250 88 190 200 243 151 16 96 132 250 148 249 222 86 222 234 247 16 226 2 173 235 146 188 144 199 31 33 192 11 58 166 92 214 165 121 224 237 253 30 66 220 163 29 202 121 181 152 45 222 214 244 16 226 18 109 168 205 236 144 159 63 65 128 87 116 130 58 106 151 30 121 105 5 1 30 208 46 229 130 218 166 195 91 8 198 21 65 54 213 58 13 26 28 12 2 188 161 83 180 170 17 113 209 220 224 16 192 173 175 246 40 23 53 42 14 126 92 60 8 113 141 182 52 46 60 154 19 21 2 56 206 208 154 198 134 67 51 146 64 128 39 180 79 25 238 182 242 173 211 66 136 3 141 111 143 122 38 133 0 99 141 111 143 122 38 229 63 4 176 121 11 97 220 230 151 24 211 14 155 63 163 152 182 249 71 134 105 155 75 9 76 155 94 204 217 92 78 99 218 230 3 13 166 223 31 41 41 87 212 46 61 222 202 244 96 220 230 67 61 166 109 110 171 96 218 109 108 29 81 218 219 216 194 248 57 178 183 181 136 233 59 180 77 105 107 115 23 211 118 182 215 49 105 251 5 7 102 7 200 173 91 110 240 111 239 21 83 161 80 40 68 162 170 38 73 22 63 24 18 40 121 38 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 7440 234 240 98 2 7568 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 7312 754 1600 672 7312 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 461 1 514 101 101 7248 754 1808 98 1 32 7248 754 1856 98 1 8 'Play' 7248 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 230 0 0 0 0 0 0 0 24 1 0 0 50 0 0 0] 98 1 7312 1664 0 27 410 928 98 14 0 6160 98 2 8 1140850688 131073 8096 0 0 0 7 0 0 0 8096 0 410 1008 98 25 0 8096 98 2 8 1140853580 131137 8160 0 0 514 101 101 515 0 0 0 8160 0 8 4294905523 0 234 256 98 2 9089 1138 9089 0 8160 1 1170 8 #nextGridExtent 8 'Change Grid Size' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 0 132 73 68 65 84 104 67 237 214 65 10 128 48 12 68 209 222 255 154 82 240 18 86 167 48 184 48 66 137 216 133 242 31 116 211 9 13 217 148 20 0 0 126 175 181 182 232 108 151 83 29 7 202 166 214 167 245 7 247 27 142 131 217 245 105 12 96 142 3 6 24 81 131 234 55 79 186 91 29 7 179 235 1 224 99 244 165 177 11 117 142 131 108 125 26 3 152 227 128 1 70 212 128 93 8 0 158 211 151 198 46 212 57 14 178 245 105 12 96 142 3 6 24 81 3 118 33 0 0 222 87 202 1 25 193 5 201 252 203 203 253 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 8288 234 240 98 2 8416 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 8160 754 1600 672 8160 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 903 1 514 101 101 8096 754 1808 98 1 32 8096 754 1856 98 1 8 'Change Grid Size' 8096 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 195 1 0 0 0 0 0 0 245 1 0 0 50 0 0 0] 98 1 8160 1664 0 27 1664 0 27 410 592 98 15 0 416 98 2 8 1140850688 131073 8944 0 0 0 7 0 0 0 8944 0 234 256 672 0 690 202 208 98 1 754 784 98 2 514 901 101 514 101 801 8944 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 194 1 0 0 50 0 0 0 244 1 0 0 194 1 0 0] 98 3 410 928 98 14 0 8944 98 2 8 1140850688 131073 9184 0 0 0 7 0 0 0 9184 0 410 1008 98 25 0 9184 98 2 8 1140853580 131137 9248 0 0 514 101 101 515 0 0 0 9248 0 8 4294905523 0 234 256 98 2 9105 1138 9105 0 9248 1 1170 8 #pasteClipboard 8 'Paste from Clipboard' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 2 117 73 68 65 84 104 67 237 151 59 104 20 81 20 134 215 196 7 130 90 136 162 96 26 145 248 64 148 8 22 150 130 165 118 130 22 54 86 17 137 32 136 104 105 107 225 11 131 72 72 111 227 171 87 27 145 180 65 80 68 236 4 65 155 160 137 98 145 152 93 191 115 230 223 69 163 187 115 38 59 179 154 112 63 248 185 143 57 255 57 247 204 238 108 38 181 68 34 145 72 36 18 137 255 156 70 163 177 66 211 68 229 212 235 245 205 220 241 77 90 118 132 184 62 139 197 179 11 13 162 141 255 252 211 226 16 199 209 11 180 86 91 191 193 254 26 116 18 61 64 159 80 157 67 59 54 135 143 232 33 203 211 140 27 100 43 14 9 134 73 48 237 153 23 192 254 156 166 14 235 207 232 152 124 87 181 119 159 161 223 147 129 205 217 59 131 62 216 245 8 196 78 163 107 104 139 210 196 193 52 163 60 127 192 181 89 77 109 254 14 237 148 205 124 207 116 201 174 221 208 222 14 52 161 237 194 224 181 27 116 142 105 235 134 228 146 89 255 14 201 252 19 96 124 139 246 203 210 188 203 83 118 173 9 235 187 11 247 242 32 222 152 69 243 218 114 88 63 101 216 170 114 157 201 44 25 24 223 160 59 191 104 84 227 32 151 87 202 98 158 221 110 40 8 121 140 9 116 30 29 64 235 217 238 71 171 153 111 99 60 204 120 1 61 66 47 89 15 169 100 123 8 106 129 105 92 219 29 33 238 148 44 97 240 60 71 135 148 34 23 44 171 136 223 199 216 249 215 202 179 139 2 13 220 146 37 23 98 191 49 12 163 62 217 203 197 171 136 2 13 132 30 84 226 236 217 217 43 91 53 168 150 19 105 128 48 251 190 126 205 28 237 33 230 59 26 144 173 58 84 207 137 52 64 204 65 133 231 66 236 99 134 248 79 226 98 200 74 101 4 27 24 81 120 8 226 71 101 173 6 213 113 130 13 140 41 60 12 158 139 178 151 143 106 56 193 6 38 21 30 6 207 60 58 161 20 229 162 26 78 176 129 41 29 104 6 189 71 147 232 9 186 135 110 163 43 104 4 217 139 220 17 210 14 49 14 160 214 75 31 243 61 232 146 150 221 145 29 61 131 164 145 6 236 47 230 58 180 168 135 19 255 81 188 95 34 181 66 216 193 155 148 150 180 13 228 191 140 126 148 90 203 79 46 122 208 128 31 222 88 170 13 24 115 210 210 107 64 101 172 142 49 166 237 238 80 78 135 164 61 105 192 40 173 150 242 57 203 161 129 87 232 102 85 82 25 135 117 249 13 244 146 210 26 32 81 238 171 113 21 80 247 186 142 208 29 36 58 139 236 191 166 158 65 189 215 104 187 142 144 72 36 18 137 196 114 167 86 251 9 254 86 159 253 193 150 31 159 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 9376 234 240 98 2 9504 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 9248 754 1600 672 9248 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 241 514 101 101 9184 754 1808 98 1 32 9184 754 1856 98 1 8 'Paste' 9184 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 120 0 0 0 50 0 0 0 170 0 0 0] 98 1 9248 1664 0 27 410 928 98 14 0 8944 98 2 8 1140850688 131073 10032 0 0 0 7 0 0 0 10032 0 410 1008 98 25 0 10032 98 2 8 1140853580 131137 10096 0 0 514 101 101 515 0 0 0 10096 0 8 4294905523 0 234 256 98 2 9103 1138 9103 0 10096 1 1170 8 #copyToClipboard 8 'Copy to Clipboard' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 2 85 73 68 65 84 104 67 237 151 61 107 20 81 20 134 119 203 245 3 162 133 104 37 54 18 21 100 181 83 20 187 52 246 9 10 41 66 18 97 127 64 98 99 149 94 180 17 20 69 81 176 244 31 136 127 65 36 226 71 32 93 250 152 15 19 16 153 228 185 231 190 19 25 221 153 157 217 185 187 100 229 62 240 114 247 222 115 206 123 238 9 153 77 166 17 137 68 34 145 72 164 15 146 36 121 133 142 106 59 122 236 1 3 44 163 139 58 26 45 220 0 14 6 216 66 211 58 30 29 116 255 3 24 226 5 203 17 133 15 63 254 218 89 24 226 19 203 184 82 14 23 92 236 4 186 193 37 167 208 156 187 112 55 136 109 162 187 42 235 31 188 238 97 180 225 109 139 33 111 29 77 170 244 0 206 206 162 37 228 30 214 68 233 165 32 253 25 106 201 170 58 20 111 202 171 16 242 86 208 121 149 25 236 79 162 167 232 151 210 250 130 250 143 127 123 151 70 30 133 96 254 21 157 81 137 193 254 26 90 83 74 109 240 218 64 83 178 47 143 234 13 12 190 160 39 93 116 78 233 6 251 9 180 163 178 32 224 183 139 58 106 81 30 213 27 24 60 215 113 46 164 181 201 219 242 21 97 192 239 59 75 91 45 170 225 45 60 189 6 32 222 66 223 148 30 4 252 222 162 227 106 81 29 249 24 37 6 88 82 106 6 206 221 3 254 24 221 65 87 57 58 205 218 98 109 90 66 23 136 255 68 243 178 238 31 249 25 24 230 14 64 236 20 202 252 234 176 255 128 110 241 177 169 180 127 240 153 89 168 113 207 218 101 165 212 67 158 6 166 69 3 60 80 154 203 219 65 179 124 204 189 120 138 175 248 3 117 175 89 142 41 92 31 111 235 201 27 128 80 147 216 170 114 220 31 179 235 10 245 196 213 56 168 217 70 51 58 14 135 252 13 26 116 29 128 243 43 138 187 175 186 155 58 46 133 234 62 163 75 58 10 139 107 144 66 147 188 1 22 20 175 252 19 164 230 37 26 220 11 141 221 92 20 12 240 14 189 209 182 54 120 93 64 139 218 214 67 119 55 10 6 120 79 120 76 219 90 224 117 27 175 31 121 189 42 99 55 23 5 3 76 232 99 45 240 185 143 126 23 245 170 140 221 92 4 51 205 65 109 140 56 64 138 252 140 56 64 15 212 198 136 3 164 200 207 192 212 189 211 62 26 148 212 198 96 31 126 128 97 18 108 0 140 130 190 93 149 133 190 15 117 133 122 96 212 65 219 242 29 10 244 115 255 220 101 222 179 35 145 72 36 18 249 143 105 52 246 1 47 10 118 73 154 19 231 163 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 10224 234 240 98 2 10352 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 10096 754 1600 672 10096 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 351 514 101 101 10032 754 1808 98 1 32 10032 754 1856 98 1 8 'Copy' 10032 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 175 0 0 0 50 0 0 0 225 0 0 0] 98 1 10096 1664 0 27 410 928 98 14 0 8944 98 2 8 1140850688 131073 10880 0 0 0 7 0 0 0 10880 0 410 1008 98 25 0 10880 98 2 8 1140853580 131137 10944 0 0 514 101 101 515 0 0 0 10944 0 8 4294905523 0 234 256 98 2 10061 1138 10061 0 10944 1 1170 8 #randomFavourite 8 'Load Random Favourite' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 2 121 73 68 65 84 104 67 237 153 205 75 84 97 24 197 103 163 179 41 148 236 195 212 133 16 86 80 155 86 137 70 237 218 229 178 165 238 202 173 91 177 77 248 17 237 67 42 255 149 72 4 23 21 65 101 162 82 27 23 6 181 208 210 74 250 154 241 247 204 123 146 32 223 153 123 239 124 220 119 228 254 224 48 51 247 158 231 60 231 234 112 113 198 92 70 70 70 70 115 80 40 20 122 208 4 90 44 22 139 159 81 145 231 59 232 5 154 70 125 178 86 4 239 25 52 137 158 89 22 143 198 38 90 64 227 168 75 214 234 97 65 43 129 83 104 215 74 251 224 252 47 52 139 142 106 244 63 176 29 225 252 3 243 186 169 131 225 252 119 116 151 167 173 26 77 6 1 237 4 45 148 82 35 130 255 45 234 86 196 62 118 12 45 201 22 149 121 212 174 136 120 176 44 143 98 149 255 11 115 107 232 180 162 236 7 209 201 235 85 119 54 54 118 17 241 127 19 44 188 239 230 147 193 252 18 58 193 211 227 60 190 113 71 19 115 79 181 162 193 192 121 150 150 125 159 70 129 140 151 38 189 76 140 117 65 231 84 175 50 152 231 52 27 12 116 122 172 122 229 193 152 199 95 186 77 6 134 221 110 243 170 233 7 227 21 231 15 15 46 96 80 53 253 96 186 45 127 136 220 82 77 63 92 192 132 204 193 65 183 59 170 233 231 48 92 64 176 111 33 235 166 154 126 48 13 200 31 28 214 77 53 253 224 179 63 222 182 220 72 80 68 187 141 26 24 31 106 40 24 232 244 72 245 42 131 249 44 250 169 217 212 177 46 214 73 245 162 193 192 180 230 83 135 46 51 170 21 29 230 90 24 124 226 34 210 131 14 79 121 72 246 193 134 193 54 2 236 99 95 42 176 251 57 15 109 170 147 12 66 142 161 87 46 178 113 176 243 53 234 80 141 234 32 232 36 90 86 118 221 97 215 10 58 165 245 181 129 192 46 244 78 59 234 6 59 222 163 30 173 173 45 228 247 18 190 238 86 213 30 101 247 106 93 125 96 73 31 218 112 43 107 7 153 31 80 188 123 125 82 88 116 1 125 212 238 170 33 235 19 186 168 248 198 192 194 75 104 83 29 18 99 25 150 165 216 198 194 226 203 232 139 186 196 134 217 109 212 175 184 116 160 192 85 244 85 157 34 195 204 55 116 77 49 233 66 145 235 168 236 119 167 255 98 94 155 209 120 24 80 232 6 250 161 142 94 204 131 134 52 22 22 20 187 137 188 223 232 113 238 183 121 100 15 19 10 14 163 63 234 188 143 29 67 35 178 133 13 69 71 81 65 221 173 188 49 170 211 205 1 133 199 92 239 18 99 58 220 92 80 220 254 93 52 174 151 25 25 25 25 135 142 92 110 15 156 236 46 180 246 34 82 52 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 11072 234 240 98 10 1346 0 16 0 0 0 0 3 514 81 81 5 1346 0 16 0 0 0 0 3 514 81 81 1 1346 0 16 0 0 0 0 3 514 81 81 3 1346 0 16 0 0 0 0 3 514 81 81 7 11200 9 0 1 0 514 81 81 514 91 91 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 10944 754 1600 672 10944 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 2 754 784 98 2 514 1 481 514 101 101 10880 754 1856 98 1 8 'Load a Random Favourite' 10880 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 240 0 0 0 50 0 0 0 34 1 0 0] 98 1 10944 1664 0 27 1664 0 27 410 592 98 15 0 416 98 2 8 1140850688 131073 11824 0 0 0 7 0 0 0 11824 0 234 256 672 0 690 202 208 98 1 754 784 98 2 514 1 101 514 101 801 11824 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 50 0 0 0 50 0 0 0 194 1 0 0] 98 3 410 928 98 14 0 11824 98 2 8 1140850688 131073 12064 0 0 0 7 0 0 0 12064 0 410 1008 98 25 0 12064 98 2 8 1140853580 131137 12128 0 0 514 101 101 515 0 0 0 12128 0 8 4294905523 0 234 256 98 2 9107 1138 9107 0 12128 1 1170 8 #beChromaticScale 8 'Chromatic Scale' 1 1 1234 1266 0 16 1298 0 8 #[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 48 0 0 0 48 8 6 0 0 0 87 2 249 135 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 4 103 65 77 65 0 0 177 143 11 252 97 5 0 0 0 9 112 72 89 115 0 0 14 195 0 0 14 195 1 199 111 168 100 0 0 1 57 73 68 65 84 104 67 237 152 49 74 3 65 24 133 87 155 96 99 35 41 36 133 218 40 36 119 240 2 54 86 41 4 43 239 33 8 94 64 8 196 198 3 88 164 142 39 240 0 130 96 161 55 176 176 210 66 221 245 27 125 8 42 51 165 243 2 255 7 143 236 108 222 192 247 138 52 105 130 32 8 2 107 218 182 157 144 67 178 211 117 221 178 94 47 14 72 127 195 136 71 114 69 78 200 30 233 171 230 139 220 179 48 226 86 85 79 228 89 68 85 79 228 88 68 85 79 228 88 68 85 79 228 88 68 85 79 146 32 63 212 246 211 52 131 170 158 36 65 252 207 201 22 143 251 124 30 147 25 185 39 111 228 93 85 79 52 96 170 227 15 120 191 74 134 58 122 82 26 176 16 196 128 218 196 128 218 196 128 218 196 128 218 196 128 218 196 128 218 196 128 255 4 215 37 100 87 200 26 25 112 222 180 31 128 220 136 92 144 7 242 154 132 127 99 59 0 177 93 242 44 207 44 116 38 186 226 5 98 215 114 44 66 239 84 87 188 64 236 69 142 69 232 29 233 138 23 184 61 125 41 230 65 62 177 173 43 94 32 54 147 103 22 58 115 213 253 64 110 131 220 201 245 15 124 119 67 214 85 247 4 193 30 25 147 51 114 73 210 159 86 83 114 64 122 170 5 65 16 4 142 52 205 7 29 161 241 209 147 71 207 236 0 0 0 0 73 69 78 68 174 66 96 130] 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 12256 234 240 98 2 12384 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 12128 754 1600 672 12128 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 369 514 101 101 12064 754 1808 98 1 32 12064 754 1856 98 1 8 'Chromatic Scale' 12064 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 184 0 0 0 50 0 0 0 234 0 0 0] 98 1 12128 1664 0 27 410 928 98 14 0 11824 98 2 8 1140850688 131073 12912 0 0 0 7 0 0 0 12912 0 410 1008 98 25 0 12912 98 2 8 1140853580 131137 12976 0 0 514 101 101 515 0 0 0 12976 0 8 4294905523 0 234 256 98 2 9109 1138 9109 0 12976 1 1170 8 #bePentatonicScale 8 'Pentatonic Scale' 1 1 1234 1266 0 16 1298 0 12368 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 13104 234 240 98 2 13216 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 12976 754 1600 672 12976 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 251 514 101 101 12912 754 1808 98 1 32 12912 754 1856 98 1 8 'Pentatonic Scale' 12912 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 125 0 0 0 50 0 0 0 175 0 0 0] 98 1 12976 1664 0 27 410 928 98 14 0 11824 98 2 8 1140850688 131073 13744 0 0 0 7 0 0 0 13744 0 410 1008 98 25 0 13744 98 2 8 1140853580 131137 13808 0 0 514 101 101 515 0 0 0 13808 0 8 4294905523 0 234 256 98 2 9111 1138 9111 0 13808 1 1170 8 #beHangScale 8 'Hangdrum Scale' 1 1 1234 1266 0 16 1298 0 12368 1346 0 16 0 0 0 0 3 514 81 81 1 98 1 13936 234 240 98 2 14048 1 0 1 0 514 81 81 514 101 101 0 0 690 202 208 98 2 754 784 98 2 514 1 1 514 101 101 13808 754 1600 672 13808 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 50 0 0 0 50 0 0 0] 98 0 1664 0 27 690 202 208 98 3 754 784 98 2 514 1 481 514 101 101 13744 754 1808 98 1 32 13744 754 1856 98 1 8 'Hangdrum Scale' 13744 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 240 0 0 0 50 0 0 0 34 1 0 0] 98 1 13808 1664 0 27 1664 0 27 410 8 ##(Smalltalk.ReferenceView) 98 14 0 416 98 2 8 1140850688 131073 14576 0 786694 ##(Smalltalk.IndexedColor) 33554447 0 7 0 0 0 14576 1180166 ##(Smalltalk.ResourceIdentifier) 8 ##(Smalltalk.PlimbolePresenter) 8 #resource_Default_view 0 690 202 208 98 1 754 784 98 2 514 101 101 514 801 801 14576 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 50 0 0 0 50 0 0 0 194 1 0 0 194 1 0 0] 672 1664 0 27 234 256 98 10 14576 8 'plimbole' 11824 8 'left' 6160 8 'bottom' 8944 8 'right' 576 8 'top' 0 0 0 0 0 1 0 0 514 1321 1401 514 481 561 1 0 0 690 202 208 98 3 754 784 98 2 514 4935 21 514 1033 1079 416 754 1856 98 1 8 'Plimbole' 416 754 8 #updateMenuBar 672 416 850 8 #[44 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 163 9 0 0 10 0 0 0 167 11 0 0 37 2 0 0] 98 5 14576 6160 576 8944 11824 1664 0 27 )!

uninitialize
	"Private - Uninitialize the receiver as it is about to be removed from the system.

	self uninitialize.
	"

	Smalltalk developmentSystem
		removeSystemFolderIconNamed: self displayString! !
!PlimboleShell class categoriesFor: #defaultModel!private! !
!PlimboleShell class categoriesFor: #displayOn:!displaying!public! !
!PlimboleShell class categoriesFor: #icon!constants!public! !
!PlimboleShell class categoriesFor: #initialize!development!initializing!private! !
!PlimboleShell class categoriesFor: #resource_Default_view!public!resources-views! !
!PlimboleShell class categoriesFor: #uninitialize!development!initializing!private! !
