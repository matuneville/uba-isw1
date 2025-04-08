!classDefinition: #Power category: #'3.Replace-if-Type+State'!
Object subclass: #Power
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Power methodsFor: 'movement' stamp: 'MN 4/8/2025 13:15:19'!
accelerate: aVehicle
	self subclassResponsibility ! !


!classDefinition: #PowerOff category: #'3.Replace-if-Type+State'!
Power subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOff methodsFor: 'movement' stamp: 'MN 4/8/2025 13:23:05'!
accelerate: aVehicle
	aVehicle accelerateWhenTurnedOff! !


!classDefinition: #PowerOn category: #'3.Replace-if-Type+State'!
Power subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!PowerOn methodsFor: 'movement' stamp: 'MN 4/8/2025 13:22:45'!
accelerate: aVehicle
	aVehicle accelerateWhenTurnedOn! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerStatus speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'MN 4/8/2025 13:13:57'!
initialize
	powerStatus := PowerOff new.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'MN 4/8/2025 14:26:59'!
accelerate
	powerStatus accelerate: self! !

!Vehicle methodsFor: 'move' stamp: 'MN 4/8/2025 14:23:28'!
accelerateWhenTurnedOff
	self error: self canNotAccelerateErrorMessage! !

!Vehicle methodsFor: 'move' stamp: 'MN 4/8/2025 14:25:46'!
accelerateWhenTurnedOn
	self subclassResponsibility ! !


!Vehicle methodsFor: 'on/off' stamp: 'MN 4/8/2025 14:19:54'!
turnOff
	powerStatus := PowerOff new.! !

!Vehicle methodsFor: 'on/off' stamp: 'MN 4/8/2025 14:19:44'!
turnOn
	powerStatus := PowerOn new.! !


!Vehicle methodsFor: 'error messages' stamp: 'MN 4/8/2025 14:23:40'!
canNotAccelerateErrorMessage
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'movement' stamp: 'MN 4/8/2025 14:25:25'!
accelerateWhenTurnedOn
	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter)! !


!Helicopter methodsFor: 'error_msg' stamp: 'MN 4/8/2025 14:24:02'!
canNotAccelerateErrorMessage
	^'Can not fly when turned off'! !


!Helicopter methodsFor: 'initialization' stamp: 'MN 4/8/2025 13:13:08'!
initialize
	super initialize.
	altitude := 0 * meter.! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!
!Motorcycle commentStamp: '<historical>' prior: 0!
El initialize queda implícito (al hacer Motorcycle new, se utiliza el initialize del padre, Vehicle)!


!Motorcycle methodsFor: 'movement' stamp: 'MN 4/8/2025 14:26:23'!
accelerateWhenTurnedOn
	speed := speed + (20 * kilometer / hour)! !


!Motorcycle methodsFor: 'error_msg' stamp: 'MN 4/8/2025 14:24:16'!
canNotAccelerateErrorMessage
	^'Can not speed up when turned off'! !
