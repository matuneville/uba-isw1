!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'MN 4/4/2025 21:31:24'!
initialize

	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'MN 4/4/2025 21:43:30'!
accelerateWithKMH: aSpeedToSum

	speed := speed + (aSpeedToSum * kilometer / hour).! !


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'movement' stamp: 'MN 4/6/2025 21:14:00'!
accelerate
	self accelerateWithKMH: 10.
	altitude := altitude + (5 * meter)
	! !


!Helicopter methodsFor: 'initialization' stamp: 'MN 4/4/2025 21:30:55'!
initialize

	super initialize.
	
	altitude := 0 * meter! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'movement' stamp: 'MN 4/6/2025 21:14:12'!
accelerate
	self accelerateWithKMH: 20! !
