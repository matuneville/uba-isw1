!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionLoggers headingLoggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MN 6/25/2025 19:17:55'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	positionLoggers := Set new.
	headingLoggers := Set new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'MN 6/25/2025 19:25:39'!
rotateLeft
	
	head rotateLeft.
	
	headingLoggers do: [:eachLogger | eachLogger register: head className].! !

!MarsRover methodsFor: 'heading' stamp: 'MN 6/25/2025 19:25:42'!
rotateRight
	
	head rotateRight.
	
	headingLoggers do: [:eachLogger | eachLogger register: head className].! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'MN 6/25/2025 19:18:52'!
moveBackward
	
	head moveBackward.
	
	positionLoggers do: [ :eachLogger | eachLogger register: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'MN 6/25/2025 19:18:56'!
moveForward
	
	head moveForward.
	
	positionLoggers do: [ :eachLogger | eachLogger register: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'MATI 6/24/2025 19:45:57'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [^ self moveForward].
	(self isBackwardCommand: aCommand) ifTrue: [^ self moveBackward].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'log' stamp: 'MN 6/25/2025 19:19:22'!
addHeadingLogger: headingLogger 
	
	headingLoggers add: headingLogger.! !

!MarsRover methodsFor: 'log' stamp: 'MN 6/25/2025 15:32:13'!
addPositionLogger: positionLogger 
	positionLoggers add: positionLogger.! !

!MarsRover methodsFor: 'log' stamp: 'MATI 6/24/2025 20:26:06'!
headingLogs
	^ headingLog.! !

!MarsRover methodsFor: 'log' stamp: 'MATI 6/24/2025 20:30:51'!
movementLogs
	^positionLog.! !

!MarsRover methodsFor: 'log' stamp: 'MATI 6/24/2025 20:30:38'!
positionHeadingLogs
	^positionheadingLog! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLogger category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'log rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'register' stamp: 'MN 6/25/2025 15:35:04'!
register: someData

	self subclassResponsibility! !


!MarsRoverLogger methodsFor: 'initialize' stamp: 'MN 6/25/2025 15:47:35'!
initialize
	
	log := ReadWriteStream with: 'Logs:'.! !


!MarsRoverLogger methodsFor: 'log' stamp: 'MN 6/25/2025 15:33:37'!
logStream
	^log! !


!classDefinition: #HeadingLogger category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #HeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogger methodsFor: 'register' stamp: 'MN 6/25/2025 19:28:13'!
register: aMarsRoverHeading

	log newLine.
	log nextPutAll: aMarsRoverHeading.! !


!classDefinition: #PositionAndHeadingLogger category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionAndHeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionAndHeadingLogger methodsFor: 'register' stamp: 'MN 6/25/2025 19:33:38'!
register: aPositionOrHeading 
	
	log newLine.
	
	(aPositionOrHeading isKindOf: Point) ifTrue:[
		aPositionOrHeading printOn: log.
	]
	ifFalse:[
		log nextPutAll: aPositionOrHeading.
	].! !


!classDefinition: #PositionLogger category: #'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogger methodsFor: 'register' stamp: 'MN 6/25/2025 15:40:25'!
register: aPosition

	log newLine.
	aPosition printOn: log.! !


!classDefinition: #MarsRoverLogTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:14:57'!
test01WhenFollowingPositionAndMarsRoverDoesNotMoveLogsEmpty

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	positionLogger := PositionLogger new.
	
	self
		assert: positionLogger logStream contents
		equals: (self logWith: #()).
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:15:22'!
test02WhenFollowingPositionAndMarsRoverMovesLogsMovements

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	positionLogger := PositionLogger new.
	marsRover addPositionLogger: positionLogger.
	marsRover process: 'ff'.
	
	self
		assert: positionLogger logStream contents
		equals: (self logWith: #('1@2' '1@3'))
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:17:38'!
test03WhenFollowingPositionAndMarsRoverMovesAndChangesHeadingLogsOnlyMovements

	| marsRover positionLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	positionLogger := PositionLogger new.
	marsRover addPositionLogger: positionLogger.
	marsRover process: 'frlfrrb'.
	
	self
		assert: positionLogger logStream contents
		equals: (self logWith: #('1@2' '1@3' '1@4'))
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:17:48'!
test04WhenFollowingHeadingAndMarsRoverDoesNotMoveLogsEmpty

	| marsRover headingLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	headingLogger := HeadingLogger new.
	marsRover addHeadingLogger: headingLogger.
	
	self
		assert: headingLogger logStream contents
		equals: (self logWith: #())
	
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:18:32'!
test05WhenFollowingHeadingAndMarsRoverChangesHeadingLogsHeadings

	| marsRover headingLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	headingLogger := HeadingLogger new.
	marsRover addHeadingLogger: headingLogger.
	marsRover process: 'rrl'.
	
	self
		assert: headingLogger logStream contents
		equals: (self logWith: #(
			'MarsRoverHeadingEast'
			'MarsRoverHeadingSouth'
			'MarsRoverHeadingEast'
		)).
	
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:18:56'!
test06WhenFollowingHeadingAndMarsRoverChangesHeadingAndMovesLogsOnlyHeadings

	| marsRover headingLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	headingLogger := HeadingLogger new.
	marsRover addHeadingLogger: headingLogger.
	marsRover process: 'lfrfllbb'.
	
	self
		assert: headingLogger logStream contents
		equals: (self logWith: #(
			'MarsRoverHeadingWest'
			'MarsRoverHeadingNorth'
			'MarsRoverHeadingWest'
			'MarsRoverHeadingSouth'
		)).
	
	

	! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'MN 6/25/2025 20:19:36'!
test07WhenFollowingHeadingAndPositionAndMarsRoverChangesHeadingAndMovesLogsBoth

	| marsRover positionAndHeadingLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north.
	positionAndHeadingLogger := PositionAndHeadingLogger new.
	marsRover addHeadingLogger: positionAndHeadingLogger.
	marsRover addPositionLogger: positionAndHeadingLogger.
	marsRover process: 'ffrrblf'.

	"log add: 1@2; add: 1@3; add: self east; add: self south; add: 1@4; add: self east; add: 2@4."
	
	self
		assert: positionAndHeadingLogger logStream contents
		equals: (self logWith: #(
			'1@2'
			'1@3'
			'MarsRoverHeadingEast'
			'MarsRoverHeadingSouth'
			'1@4'
			'MarsRoverHeadingEast'
			'2@4'
		)).
	

	! !


!MarsRoverLogTest methodsFor: 'headings' stamp: 'MATI 6/24/2025 20:05:48'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'MATI 6/24/2025 19:35:25'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'MATI 6/24/2025 20:05:53'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'MATI 6/24/2025 20:05:58'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverLogTest methodsFor: 'log style' stamp: 'MN 6/25/2025 20:19:51'!
logWith: arrayOfLogs

	| log |
	
	log := 'Logs:'.
	
	arrayOfLogs do: [:eachLogLine |
		log := log , Character lf asString , eachLogLine 
	].
	
	^ log.
	
	! !


!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !
