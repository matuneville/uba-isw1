!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'engine speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'MN 4/10/2025 09:53:38'!
initialize
	speed := 0 * kilometer / hour.
	engine := EngineOff newWith: self.! !


!Automobile methodsFor: 'engine_status' stamp: 'MN 4/10/2025 09:53:26'!
turnOff
	(engine isKindOf: EngineOff ) ifTrue: [
		self error: 'Can not turn off when engine is already turned off'
	].
	speed := 0 * kilometer / hour.
	engine := EngineOff newWith: self.! !

!Automobile methodsFor: 'engine_status' stamp: 'MN 4/10/2025 09:42:19'!
turnOn
	(engine isKindOf: EngineOn ) ifTrue: [
		self error: 'Can not turn on when engine is already turned on'
	].
	engine := EngineOn newWith: self.! !


!Automobile methodsFor: 'move' stamp: 'MN 4/7/2025 15:17:02'!
accelerate
	engine accelerate! !

!Automobile methodsFor: 'move' stamp: 'MN 4/10/2025 09:48:23'!
accelerateWhenEngineIsOff
	self error: 'Can not drive when turned off'! !

!Automobile methodsFor: 'move' stamp: 'MN 4/10/2025 09:43:12'!
accelerateWhenEngineIsOn
	speed := speed + (10 * kilometer / hour)! !


!classDefinition: #EngineStatus category: #'2.Replace-if-State'!
Object subclass: #EngineStatus
	instanceVariableNames: 'automobile'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!


!classDefinition: #EngineOff category: #'2.Replace-if-State'!
EngineStatus subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOff methodsFor: 'engine_actions' stamp: 'MN 4/10/2025 09:47:11'!
accelerate
	automobile accelerateWhenEngineIsOff
	! !


!EngineOff methodsFor: 'initialization' stamp: 'MN 4/10/2025 09:46:21'!
initializeWith: anAutomobile
	automobile := anAutomobile! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EngineOff class' category: #'2.Replace-if-State'!
EngineOff class
	instanceVariableNames: ''!

!EngineOff class methodsFor: 'initialization' stamp: 'MN 4/10/2025 09:46:21'!
newWith: anAutomobile
	^ self new initializeWith: anAutomobile! !


!classDefinition: #EngineOn category: #'2.Replace-if-State'!
EngineStatus subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOn methodsFor: 'engine_actions' stamp: 'MN 4/10/2025 09:42:43'!
accelerate
	automobile accelerateWhenEngineIsOn 
	! !


!EngineOn methodsFor: 'initialization' stamp: 'MN 4/10/2025 09:41:32'!
initializeWith: anAutomobile
	automobile := anAutomobile! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EngineOn class' category: #'2.Replace-if-State'!
EngineOn class
	instanceVariableNames: ''!

!EngineOn class methodsFor: 'initialization' stamp: 'MN 4/10/2025 09:41:21'!
newWith: anAutomobile
	^ self new initializeWith: anAutomobile! !
