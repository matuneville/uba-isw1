!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'engine'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'MN 4/7/2025 15:10:51'!
initialize
	engine := EngineOff new.! !


!Automobile methodsFor: 'engine_status' stamp: 'MN 4/7/2025 15:18:02'!
getSpeed
	^engine getSpeed! !

!Automobile methodsFor: 'engine_status' stamp: 'MN 4/7/2025 15:28:26'!
turnOff
	(engine isKindOf: EngineOff ) ifTrue: [
		self error: 'Can not turn off when engine is already turned off'
	].
	engine := EngineOff new.! !

!Automobile methodsFor: 'engine_status' stamp: 'MN 4/7/2025 15:33:19'!
turnOn
	(engine isKindOf: EngineOn ) ifTrue: [
		self error: 'Can not turn on when engine is already turned on'
	].
	engine := EngineOn new.! !


!Automobile methodsFor: 'move' stamp: 'MN 4/7/2025 15:17:02'!
accelerate
	engine accelerate! !


!classDefinition: #Engine category: #'2.Replace-if-State'!
Object subclass: #Engine
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Engine methodsFor: 'initialization' stamp: 'MN 4/7/2025 15:06:37'!
initialize
	speed := 0 * kilometer / hour! !


!Engine methodsFor: 'status' stamp: 'MN 4/7/2025 15:18:26'!
getSpeed
	^speed! !


!classDefinition: #EngineOff category: #'2.Replace-if-State'!
Engine subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOff methodsFor: 'engine_actions' stamp: 'MN 4/7/2025 15:11:09'!
accelerate
	self error: 'Can not accelerate when engine is turned off'! !


!classDefinition: #EngineOn category: #'2.Replace-if-State'!
Engine subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOn methodsFor: 'engine_actions' stamp: 'MN 4/7/2025 15:07:50'!
accelerate
	speed := speed + (10 * kilometer / hour)! !
