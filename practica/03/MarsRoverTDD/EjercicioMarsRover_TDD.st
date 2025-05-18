!classDefinition: #MarsRover category: #EjercicioMarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'M 5/16/2025 20:42:54'!
initializeDeployedAt: aPosition withDirection: aDirection

	currentPosition := aPosition.
	currentDirection := aDirection.! !


!MarsRover methodsFor: 'testing' stamp: 'M 5/16/2025 20:41:56'!
pointingAt: aDirection 
	^ aDirection = currentDirection.! !

!MarsRover methodsFor: 'testing' stamp: 'M 5/16/2025 20:33:20'!
positionedAt: aPosition 
	^ currentPosition = aPosition.! !


!MarsRover methodsFor: 'movement' stamp: 'MNN 5/18/2025 12:47:01'!
move: aCollectionOfMovement 
	
	aCollectionOfMovement do: [ :eachDirection |
		(eachDirection = 'f') ifTrue:[
			currentDirection = #North ifTrue:[
				currentPosition := (currentPosition x + 1)@(currentPosition y).
			].
			currentDirection = #West ifTrue:[
				currentPosition := (currentPosition x)@(currentPosition y - 1).
			].
			currentDirection = #South ifTrue:[
				currentPosition := (currentPosition x - 1)@(currentPosition y).
			].
			currentDirection = #East ifTrue:[
				currentPosition := (currentPosition x)@(currentPosition y + 1).
			].
		].
		(eachDirection = 'b') ifTrue:[
			currentPosition := (currentPosition x - 1)@(currentPosition y).
		].
		(eachDirection = 'r') ifTrue:[
			currentDirection = #North ifTrue:[
				currentDirection := #East.
			] ifFalse:[
				currentDirection = #West ifTrue:[
					currentDirection := #North.
				] ifFalse:[
					currentDirection = #South ifTrue:[
						currentDirection := #West.
					] ifFalse:[
						currentDirection = #East ifTrue:[
							currentDirection := #South.
						].
					].
				].
			].
		].
		(eachDirection = 'l') ifTrue:[
			currentDirection = #North ifTrue:[
				currentDirection := #West.
			] ifFalse:[
				currentDirection = #West ifTrue:[
					currentDirection := #South.
				] ifFalse:[
					currentDirection = #South ifTrue:[
						currentDirection := #East.
					] ifFalse:[
						currentDirection = #East ifTrue:[
							currentDirection := #North.
						].
					].
				].
			].
		].
	].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #EjercicioMarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'M 5/16/2025 20:42:32'!
deployAt: coordinates pointingAt: aDirection  

	^self new initializeDeployedAt: coordinates withDirection: aDirection ! !


!classDefinition: #TestMarsRover category: #EjercicioMarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 20:40:14'!
test01RoverDidntMoveAndIsInInitialCoords

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	self assert: (rover positionedAt: 0@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 20:40:27'!
test02RoverDidntMoveAndIsInInitialDirection

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	self assert: (rover pointingAt: #North)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 20:41:30'!
test03RoverDidntMoveAndIsInAnotherInitialDirection

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #South.
	
	self assert: (rover pointingAt: #South)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:26:16'!
test04RoverPointingAtNorthMovesOneToForwardAndIsCorrectPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	rover move: (Array with: 'f').
	
	self assert: (rover positionedAt: 1@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:26:31'!
test05RoverPointingAtNorthMovesOneToBackwardAndIsCorrectPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	rover move: (Array with: 'b').
	
	self assert: (rover positionedAt: -1@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:26:57'!
test06RoverPointingAtNorthMovesManyToForwardAndIsCorrectPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	rover move: (Array with: 'f' with: 'f' with: 'f').
	
	self assert: (rover positionedAt: 3@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:15:21'!
test07RoverPointingAtNorthTurnsRightAndIsInSamePosition

	| rover |
	
	rover := MarsRover deployAt: 1@2 pointingAt: #North.
	
	rover move: (Array with: 'r').
	
	self assert: (rover positionedAt: 1@2)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:18:20'!
test08RoverPointingAtNorthTurnsRightAndMovesOneToForwardIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 1@2 pointingAt: #North.
	
	rover move: (Array with: 'r' with: 'f').
	
	self assert: (rover positionedAt: 1@3)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:18:07'!
test09RoverPointingAtSouthTurnsRightAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 1@2 pointingAt: #South.
	
	rover move: (Array with: 'r' with: 'f').
	
	self assert: (rover positionedAt: 1@1)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:25:37'!
test09RoverPointingAtWestTurnsRightAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 1@2 pointingAt: #West.
	
	rover move: (Array with: 'r' with: 'f').
	
	self assert: (rover positionedAt: 2@2)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:27:49'!
test10RoverPointingAtEastTurnsRightAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 1@2 pointingAt: #East.
	
	rover move: (Array with: 'r' with: 'f').
	
	self assert: (rover positionedAt: 0@2)! !

!TestMarsRover methodsFor: 'test' stamp: 'M 5/16/2025 21:36:48'!
test11RoverPointingAtNorthTurnsLeftAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	rover move: (Array with: 'l' with: 'f').
	
	self assert: (rover positionedAt: 0@-1)! !

!TestMarsRover methodsFor: 'test' stamp: 'MNN 5/18/2025 12:45:00'!
test12RoverPointingAtSouthTurnsLeftAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #South.
	
	rover move: (Array with: 'l' with: 'f').
	
	self assert: (rover positionedAt: 0@1)! !

!TestMarsRover methodsFor: 'test' stamp: 'MNN 5/18/2025 12:46:51'!
test13RoverPointingAtEastTurnsLeftAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #East.
	
	rover move: (Array with: 'l' with: 'f').
	
	self assert: (rover positionedAt: 1@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'MNN 5/18/2025 14:47:31'!
test14RoverPointingAtWestTurnsLeftAndMovesOneToForwarsIsInRightPosition

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #West.
	
	rover move: (Array with: 'l' with: 'f').
	
	self assert: (rover positionedAt: -1@0)! !

!TestMarsRover methodsFor: 'test' stamp: 'MNN 5/18/2025 14:52:29'!
test99

	| rover |
	
	rover := MarsRover deployAt: 0@0 pointingAt: #North.
	
	rover move: (OrderedCollection with: 'l' with: 'f' with: 'r' with: 'b' with: 'b').
	
	self assert: (rover positionedAt: -2@-1)! !
