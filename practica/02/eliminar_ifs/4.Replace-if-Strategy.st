!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:25:03'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:27:17'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:20'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := Vehicle electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:16'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := Vehicle gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:11'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := Vehicle helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:47:14'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:05'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:53:50'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:55:32'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!classDefinition: #Engine category: #'4.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Engine methodsFor: 'actions' stamp: 'MN 4/10/2025 16:48:45'!
accelerate: aVehicle
	self subclassResponsibility! !


!classDefinition: #ElectricEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!ElectricEngine methodsFor: 'actions' stamp: 'MN 4/10/2025 16:49:10'!
accelerate: aVehicle
	aVehicle accelerateWithElectricEngine.! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!GasolineEngine methodsFor: 'actions' stamp: 'MN 4/10/2025 16:49:20'!
accelerate: aVehicle
	aVehicle accelerateWithGasolineEngine.! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!JetFueledEngine methodsFor: 'actions' stamp: 'MN 4/10/2025 16:49:28'!
accelerate: aVehicle
	aVehicle accelerateWithJetFueledEngine.! !


!classDefinition: #Landscape category: #'4.Replace-if-Strategy'!
Object subclass: #Landscape
	instanceVariableNames: 'speedLimit'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!
!Landscape commentStamp: '<historical>' prior: 0!
Deberian ser objetos.....!


!Landscape methodsFor: 'initialization' stamp: 'MN 4/10/2025 17:00:05'!
initializeWithSpeedLimit: aSpeedLimit
	speedLimit := aSpeedLimit.! !


!Landscape methodsFor: 'speed limit' stamp: 'MN 4/10/2025 17:02:06'!
calculateSpeed: aSpeed
	"Devuelvo la velocidad que llevo, con límite en la permitida. Es decir,
	 el menor entre el límite de velocidad del Landscape y la velocidad de parámetro"
	^ speedLimit min: aSpeed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Landscape class' category: #'4.Replace-if-Strategy'!
Landscape class
	instanceVariableNames: ''!

!Landscape class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 16:59:43'!
newWithSpeedLimit: aSpeedLimit
	^ self new initializeWithSpeedLimit: aSpeedLimit.! !


!classDefinition: #PowerStatus category: #'4.Replace-if-Strategy'!
Object subclass: #PowerStatus
	instanceVariableNames: 'vehicle'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerStatus methodsFor: 'actions' stamp: 'MN 4/10/2025 10:01:39'!
accelerate
	self subclassResponsibility.! !


!PowerStatus methodsFor: 'initialization' stamp: 'MN 4/10/2025 10:01:18'!
initializeWith: aVehicle
	vehicle := aVehicle.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PowerStatus class' category: #'4.Replace-if-Strategy'!
PowerStatus class
	instanceVariableNames: ''!

!PowerStatus class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 10:00:50'!
newWith: aVehicle
	^self new initializeWith: aVehicle.! !


!classDefinition: #PowerOff category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #PowerOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerOff methodsFor: 'actions' stamp: 'MN 4/10/2025 10:02:22'!
accelerate
	vehicle accelerateWhenTurnedOff.! !


!classDefinition: #PowerOn category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #PowerOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerOn methodsFor: 'actions' stamp: 'MN 4/10/2025 10:02:34'!
accelerate
	vehicle accelerateWhenTurnedOn.! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy'!
Object subclass: #Vehicle
	instanceVariableNames: 'powerState speed engine landscape'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Vehicle methodsFor: 'initialization' stamp: 'MN 4/10/2025 12:19:39'!
initializeWithEngine: anEngine andLandscape: aLandscape
	speed := 0 * kilometer / hour.
	engine := anEngine.
	landscape := aLandscape.
	powerState := PowerOff newWith: self.! !

!Vehicle methodsFor: 'initialization' stamp: 'MN 4/10/2025 11:48:02'!
initializeWithType: typeToTake engineType: anEngineType andSurroundings: surroundings
	"altitude := 0 * meter"! !


!Vehicle methodsFor: 'movement' stamp: 'MN 4/10/2025 12:13:05'!
accelerate
	powerState accelerate.! !

!Vehicle methodsFor: 'movement' stamp: 'NR 9/7/2024 18:23:27'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'MN 4/10/2025 10:03:25'!
turnOff

	powerState := PowerOff newWith: self.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'MN 4/10/2025 10:03:25'!
turnOn

	powerState := PowerOn newWith: self.! !


!Vehicle methodsFor: 'error messages' stamp: 'MN 4/10/2025 10:09:56'!
canNotAccelerateErrorMessage

	type = #Helicopter ifTrue:[^'Can not fly when turned off'].
	"type = #Motorcycle ifTrue:[^'Can not run when turned off']."! !


!Vehicle methodsFor: 'accelerate on power' stamp: 'MN 4/10/2025 10:05:25'!
accelerateWhenTurnedOff
	self subclassResponsibility! !

!Vehicle methodsFor: 'accelerate on power' stamp: 'MN 4/10/2025 16:48:24'!
accelerateWhenTurnedOn
	engine accelerate: self.! !


!Vehicle methodsFor: 'accelerate on engine' stamp: 'MN 4/10/2025 16:53:52'!
accelerateEngineWithAnAccelerationOf: anAcceleration
	
	self accelerateOnLandscape: (speed + anAcceleration).! !

!Vehicle methodsFor: 'accelerate on engine' stamp: 'MN 4/10/2025 16:55:30'!
accelerateWithElectricEngine

	self accelerateEngineWithAnAccelerationOf: ((speed + (5 * kilometer / hour)) * 2).! !

!Vehicle methodsFor: 'accelerate on engine' stamp: 'MN 4/10/2025 16:55:26'!
accelerateWithGasolineEngine

	self accelerateEngineWithAnAccelerationOf: (10 * kilometer / hour).! !

!Vehicle methodsFor: 'accelerate on engine' stamp: 'MN 4/10/2025 16:55:14'!
accelerateWithJetFueledEngine

	self accelerateEngineWithAnAccelerationOf: (((speed amount + 1) ^ 2) * kilometer / hour).
! !


!Vehicle methodsFor: 'accelerate on landscape' stamp: 'MN 4/10/2025 12:18:10'!
accelerateOnLandscape: aSpeed
	speed := (landscape calculateSpeed: aSpeed).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 17:16:37'!
electricMotorcycle

	"^ self new initializeWithType: #Motorcycle engineType: #ElectricEngine andSurroundings: #city"
	
	^ Motorcycle newWithEngine: ElectricEngine new
				  andLandscape: (Landscape newWithSpeedLimit: (70 * kilometer / hour))

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 17:16:51'!
gasolineMotorcycle

	"^ self new initializeWithType: #Motorcycle engineType: #GasolineEngine andSurroundings: #openRoad"
	
	^ Motorcycle newWithEngine: GasolineEngine new
				  andLandscape: (Landscape newWithSpeedLimit: (130 * kilometer / hour))! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 17:16:58'!
helicopter

	"^ self new initializeWithType: #Helicopter engineType: #JetFueledEngine andSurroundings: #skies"
	
	^ Helicopter newWithEngine: JetFueledEngine new
				  andLandscape: (Landscape newWithSpeedLimit: (500 * kilometer / hour))! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MN 4/10/2025 12:19:13'!
newWithEngine: anEngine andLandscape: aLandscape
	^ self new initializeWithEngine: anEngine andLandscape: aLandscape! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Helicopter methodsFor: 'error messages' stamp: 'MN 4/10/2025 11:49:28'!
canNotAccelerateErrorMessage
	^'Can not fly when turned off' ! !


!Helicopter methodsFor: 'initialization' stamp: 'MN 4/10/2025 11:49:10'!
initialize
	altitude := 0 * meter.! !


!Helicopter methodsFor: 'on/off' stamp: 'MN 4/10/2025 11:52:25'!
turnOff
	altitude := 0 * meter.
	super turnOff.! !


!Helicopter methodsFor: 'movement' stamp: 'MN 4/10/2025 12:13:36'!
accelerate
	super accelerate.
	altitude := altitude + (5 * meter).! !

!Helicopter methodsFor: 'movement' stamp: 'MN 4/10/2025 11:59:49'!
altitudeAt: anAltitude

	^ altitude = anAltitude! !


!Helicopter methodsFor: 'accelerate on power' stamp: 'MN 4/10/2025 11:00:02'!
accelerateWhenTurnedOff
	self error: self canNotAccelerateErrorMessage.! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Motorcycle methodsFor: 'error messages' stamp: 'MN 4/10/2025 10:09:41'!
canNotAccelerateErrorMessage
	^'Can not run when turned off' ! !


!Motorcycle methodsFor: 'movement' stamp: 'MN 4/10/2025 10:12:07'!
accelerateWhenTurnedOff
	self error: self canNotAccelerateErrorMessage.! !
