!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'MN 6/9/2025 15:40:13'!
reportAccountWith: aReporter

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'MN 6/9/2025 15:40:13'!
reportAccountWith: aReporter

	self transactions do: [:eachTransaction | 
		eachTransaction reportWith: aReporter.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'MN 6/9/2025 15:40:13'!
reportAccountWith: aReporter

	transactions do: [:eachTransaction | 
		eachTransaction reportWith: aReporter.
	].! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountReporter category: #'Portfolio-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:33:27'!
processDeposit: aDeposit

	self subclassResponsibility! !

!AccountReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:33:15'!
processTransferenceDepositLeg: aTransferenceDepositLeg

	self subclassResponsibility! !

!AccountReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:33:15'!
processTransferenceWithdrawalLeg: aTransferenceWithdrawalLeg

	self subclassResponsibility! !

!AccountReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:33:34'!
processWithdrawal: aWithdrawal

	self subclassResponsibility! !


!AccountReporter methodsFor: 'initialization' stamp: 'MN 6/9/2025 15:34:14'!
initializeFor: anAccount 

	account := anAccount.! !


!AccountReporter methodsFor: 'report' stamp: 'MN 6/9/2025 15:35:31'!
generateReport

	self subclassResponsibility! !


!classDefinition: #AccountSummaryReporter category: #'Portfolio-Solucion'!
AccountReporter subclass: #AccountSummaryReporter
	instanceVariableNames: 'summaryLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporter methodsFor: 'report' stamp: 'MN 6/9/2025 15:40:13'!
generateReport

	summaryLines := OrderedCollection new.

	account reportAccountWith: self.
	
	summaryLines add: 'Balance = ', account balance asString, '.'.

	^ summaryLines.! !


!AccountSummaryReporter methodsFor: 'process transactions' stamp: 'MN 6/8/2025 17:41:37'!
processDeposit: aDeposit 
	
	summaryLines add: 'Depósito por ' , aDeposit value asString , '.'.! !

!AccountSummaryReporter methodsFor: 'process transactions' stamp: 'MN 6/8/2025 17:54:03'!
processTransferenceDepositLeg: aTransferenceDepositLeg 
	
	summaryLines add: 'Entrada por transferencia de ' , aTransferenceDepositLeg value asString , '.'.! !

!AccountSummaryReporter methodsFor: 'process transactions' stamp: 'MN 6/8/2025 17:52:49'!
processTransferenceWithdrawalLeg: aTransferenceWithdrawalLeg 
	
	summaryLines add: 'Salida por transferencia de ' , aTransferenceWithdrawalLeg value asString , '.'.! !

!AccountSummaryReporter methodsFor: 'process transactions' stamp: 'MN 6/8/2025 17:44:45'!
processWithdrawal: aWithdrawal
	
	summaryLines add: 'Extracción por ' , aWithdrawal value asString , '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReporter class' category: #'Portfolio-Solucion'!
AccountSummaryReporter class
	instanceVariableNames: ''!

!AccountSummaryReporter class methodsFor: 'instance creation' stamp: 'MN 6/8/2025 12:12:00'!
for: aReceptiveAccount 

	^self new initializeFor: aReceptiveAccount ! !


!classDefinition: #TransferenceNetReporter category: #'Portfolio-Solucion'!
AccountReporter subclass: #TransferenceNetReporter
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceNetReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:41:26'!
processDeposit: aDeposit ! !

!TransferenceNetReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:32:25'!
processTransferenceDepositLeg: aDepositLeg 
	
	net := net + aDepositLeg value.! !

!TransferenceNetReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:33:00'!
processTransferenceWithdrawalLeg: aWithdrawalLeg 
	
	net := net - aWithdrawalLeg value.! !

!TransferenceNetReporter methodsFor: 'process transactions' stamp: 'MN 6/9/2025 15:41:37'!
processWithdrawal: aWithdraw ! !


!TransferenceNetReporter methodsFor: 'report' stamp: 'MN 6/9/2025 15:39:58'!
generateReport
	
	net := 0.
	
	account reportAccountWith: self.
	
	^ net.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceNetReporter class' category: #'Portfolio-Solucion'!
TransferenceNetReporter class
	instanceVariableNames: ''!

!TransferenceNetReporter class methodsFor: 'instance creation' stamp: 'MN 6/9/2025 14:53:02'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'MN 6/8/2025 17:35:26'!
reportWith: aReporter

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'MN 6/8/2025 17:36:54'!
reportWith: aReporter 
	
	aReporter processDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceLeg category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceLeg methodsFor: 'initialize' stamp: 'MN 6/7/2025 17:08:45'!
initializeFor: anAccount asPartOf: aTransference.
	transference := aTransference.
	anAccount register: self. "Quienes ejecutan esto son instancias de DepositLeg o WithdrawalLeg"! !


!TransferenceLeg methodsFor: 'balance' stamp: 'MN 6/7/2025 17:09:47'!
affectBalance: aBalance

	self subclassResponsibility! !

!TransferenceLeg methodsFor: 'balance' stamp: 'MN 6/7/2025 17:09:07'!
value

	^transference value.! !


!TransferenceLeg methodsFor: 'reports' stamp: 'MN 6/8/2025 17:55:56'!
reportWith: aReporter

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceLeg class' category: #'Portfolio-Solucion'!
TransferenceLeg class
	instanceVariableNames: ''!


!TransferenceLeg class methodsFor: 'instance creation' stamp: 'MN 6/7/2025 17:07:52'!
for: anAccount asPartOf: aTransference
	
	^self new initializeFor: anAccount asPartOf: aTransference.! !


!classDefinition: #DepositLeg category: #'Portfolio-Solucion'!
TransferenceLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'MN 6/7/2025 17:19:20'!
affectBalance: aBalance
	
	^aBalance + self value! !


!DepositLeg methodsFor: 'accessing' stamp: 'MN 6/7/2025 17:28:56'!
withdrawalLeg
	^transference withdrawalLeg.! !


!DepositLeg methodsFor: 'reports' stamp: 'MN 6/8/2025 17:56:19'!
reportWith: aReporter 
	
	aReporter processTransferenceDepositLeg: self.! !


!classDefinition: #WithdrawalLeg category: #'Portfolio-Solucion'!
TransferenceLeg subclass: #WithdrawalLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawalLeg methodsFor: 'balance' stamp: 'MN 6/7/2025 17:10:23'!
affectBalance: aBalance
	
	^aBalance - self value! !


!WithdrawalLeg methodsFor: 'accessing' stamp: 'MN 6/7/2025 17:29:16'!
depositLeg
	^ transference depositLeg.! !


!WithdrawalLeg methodsFor: 'reports' stamp: 'MN 6/8/2025 17:55:40'!
reportWith: aReporter 
	
	aReporter processTransferenceWithdrawalLeg: self.! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'MN 6/8/2025 17:44:03'!
reportWith: aReporter 
	
	aReporter processWithdrawal: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: #'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value withdrawalLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'initialize' stamp: 'MN 6/7/2025 17:18:36'!
initializeValue: aValue from: aSenderAccount to: aRecipientAccount
		
	withdrawalLeg := WithdrawalLeg for: aSenderAccount asPartOf: self.
	depositLeg := DepositLeg for: aRecipientAccount asPartOf: self.
	value := aValue.! !

!Transference methodsFor: 'initialize' stamp: 'MN 6/7/2025 16:57:38'!
initializeValue: aValue withdrawalLeg: aWithdrawalLeg depositLeg: aDepositLeg

	value := aValue.
	withdrawalLeg := aWithdrawalLeg.
	depositLeg := aDepositLeg.! !


!Transference methodsFor: 'accessing' stamp: 'MN 6/7/2025 17:24:00'!
depositLeg
	^depositLeg! !

!Transference methodsFor: 'accessing' stamp: 'MN 6/7/2025 17:14:31'!
value
	^value ! !

!Transference methodsFor: 'accessing' stamp: 'MN 6/7/2025 17:23:47'!
withdrawalLeg
	^withdrawalLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'assertions' stamp: 'MN 6/7/2025 17:53:24'!
assertCan: senderAccount transferTo: recipientAccount
	
	senderAccount = recipientAccount ifTrue:[ self signalCannotTransferToTheSameAccount. ].! !

!Transference class methodsFor: 'assertions' stamp: 'MN 6/7/2025 17:56:21'!
assertCanTransfer: aValue
	
	aValue negative ifTrue: [ self signalCannotTransferNegativeValues ].! !


!Transference class methodsFor: 'instance creation' stamp: 'MN 6/7/2025 17:54:17'!
register: aValue from: senderAccount to: recipientAccount 
	
	self assertCan: senderAccount transferTo: recipientAccount.
	self assertCanTransfer: aValue.
	
	^self new initializeValue: aValue from: senderAccount to: recipientAccount.! !


!Transference class methodsFor: 'exceptions' stamp: 'MN 6/7/2025 17:56:18'!
signalCannotTransferNegativeValues

	^ self error: 'Cannot transfer negative values'! !

!Transference class methodsFor: 'exceptions' stamp: 'MN 6/7/2025 17:53:15'!
signalCannotTransferToTheSameAccount

	^ self error: 'Cannot transfer to the same account'! !


!classDefinition: #AccountSummaryReporterTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test01AccountWithoutTransactionsReportsOnlyBalance

	| receptiveAccount reporter summary |
	
	receptiveAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: receptiveAccount.

	summary := reporter generateReport.
	
	self assert: (summary at: 1) equals: 'Balance = 0.'.! !

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test02DepositsAreReportedInAccountSummary

	| receptiveAccount reporter summary |
	
	receptiveAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: receptiveAccount.
	
	Deposit register: 20 on: receptiveAccount.
	Deposit register: 40 on: receptiveAccount.
	
	summary := reporter generateReport.
	self assert: (summary at: 1) equals: 'Depósito por 20.'.
	self assert: (summary at: 2) equals: 'Depósito por 40.'.
	self assert: (summary at: 3) equals: 'Balance = 60.'.! !

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test03WithdrawalsAreReportedInAccountSummary

	| receptiveAccount reporter summary |
	
	receptiveAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: receptiveAccount.
	
	Withdraw register: 15 on: receptiveAccount.
	
	summary := reporter generateReport.
	self assert: (summary at: 1) equals: 'Extracción por 15.'.
	self assert: (summary at: 2) equals: 'Balance = -15.'.! !

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test04TransferenceWithdrawalLegsAreReportedInAccountSummary

	| senderAccount recipientAccount reporter summary |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: senderAccount.
	
	Transference register: 35 from: senderAccount to: recipientAccount.
	
	summary := reporter generateReport.
	self assert: (summary at: 1) equals: 'Salida por transferencia de 35.'.
	self assert: (summary at: 2) equals: 'Balance = -35.'.! !

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test05TransferenceDepositLegsAreReportedInAccountSummary

	| senderAccount recipientAccount reporter summary |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: recipientAccount.
	
	Transference register: 35 from: senderAccount to: recipientAccount.
	
	summary := reporter generateReport.
	self assert: (summary at: 1) equals: 'Entrada por transferencia de 35.'.
	self assert: (summary at: 2) equals: 'Balance = 35.'.! !

!AccountSummaryReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:28'!
test06AccountSummaryWorksAlsoOnPortfolios

	| senderAccount recipientAccount portfolio reporter summary |
	
	portfolio := Portfolio new.
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	reporter := AccountSummaryReporter for: portfolio.
	portfolio add: senderAccount; add: recipientAccount.
	
	Deposit register: 20 on: senderAccount.
	Transference register: 20 from: senderAccount to: recipientAccount.
	Withdraw register: 10 on: recipientAccount.
	
	summary := reporter generateReport.
	self assert: (summary at: 1) equals: 'Depósito por 20.'.
	self assert: (summary at: 2) equals: 'Salida por transferencia de 20.'.
	self assert: (summary at: 3) equals: 'Entrada por transferencia de 20.'.
	self assert: (summary at: 4) equals: 'Extracción por 10.'.
	self assert: (summary at: 5) equals: 'Balance = 10.'.! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferenceNetReporterTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferenceNetReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceNetReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:05'!
test01AccountWithoutTransactionsHas0AsBalance

	| receptiveAccount reporter transferenceNet |
	
	receptiveAccount := ReceptiveAccount new.
	
	reporter := TransferenceNetReporter for: receptiveAccount.
	transferenceNet := reporter generateReport.
	
	self assert: transferenceNet equals: 0.! !

!TransferenceNetReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:05'!
test02AccountWithDepositLegsHasTheSumOfItsPositiveValuesAsNet

	| senderAccount recipientAccount reporter transferenceNet |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Transference register: 10 from: senderAccount to: recipientAccount.
	Transference register: 20 from: senderAccount to: recipientAccount.
	
	reporter := TransferenceNetReporter for: recipientAccount.
	transferenceNet := reporter generateReport.
	
	self assert: transferenceNet equals: 30.! !

!TransferenceNetReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:05'!
test03AccountWithWithdrawalLegsHasTheSumOfItsNegativeValuesAsNet

	| senderAccount recipientAccount reporter transferenceNet |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Transference register: 10 from: senderAccount to: recipientAccount.
	Transference register: 20 from: senderAccount to: recipientAccount.
	
	reporter := TransferenceNetReporter for: senderAccount.
	transferenceNet := reporter generateReport.
	
	self assert: transferenceNet equals: -30.! !

!TransferenceNetReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:05'!
test04DepositsAndWithdrawalsDontAffectNet

	| receptiveAccount reporter transferenceNet |
	
	receptiveAccount := ReceptiveAccount new.
	
	Deposit register: 10 on: receptiveAccount.
	Withdraw register: 5 on: receptiveAccount.
	
	reporter := TransferenceNetReporter for: receptiveAccount.
	transferenceNet := reporter generateReport.
	
	self assert: transferenceNet equals: 0.! !

!TransferenceNetReporterTest methodsFor: 'tests' stamp: 'MN 6/9/2025 15:35:05'!
test05TransferNetIsWellCalculatedOnPortfolios

	| receptiveAccount reporter transferenceNet |
	
	receptiveAccount := ReceptiveAccount new.
	
	Deposit register: 10 on: receptiveAccount.
	Withdraw register: 5 on: receptiveAccount.
	
	reporter := TransferenceNetReporter for: receptiveAccount.
	transferenceNet := reporter generateReport.
	
	self assert: transferenceNet equals: 0.! !


!classDefinition: #TransferenceTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:14:56'!
test01TransferingZeroDoesNotAlterBalances

	| senderAccount recipientAccount |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Transference register: 0 from: senderAccount to: recipientAccount.
	
	self
		assert: senderAccount balance
		equals: 0.
	
	self
		assert: recipientAccount balance
		equals: 0.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:19:42'!
test02TransferingMoreThanZeroAffectsSendersBalance

	| senderAccount recipientAccount |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: senderAccount.
	
	Transference register: 60 from: senderAccount to: recipientAccount.
	
	self
		assert: senderAccount balance
		equals: 40.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:20:19'!
test03TransferingMoreThanZeroAffectsRecipientsBalance

	| senderAccount recipientAccount |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: senderAccount.
	
	Transference register: 60 from: senderAccount to: recipientAccount.
	
	self
		assert: recipientAccount balance
		equals: 60.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:23:29'!
test04AccountsHaveLegsRegistered

	| senderAccount recipientAccount transference |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: senderAccount.
	
	transference := Transference register: 60 from: senderAccount to: recipientAccount.
	
	self assert: (senderAccount hasRegistered: transference withdrawalLeg).
	self assert: (recipientAccount hasRegistered: transference depositLeg).
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:44:12'!
test05CanGoFromWithdrawalLegToDepositLeg

	| senderAccount recipientAccount transference |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: senderAccount.
	
	transference := Transference register: 60 from: senderAccount to: recipientAccount.
	
	self assert: transference withdrawalLeg equals: transference depositLeg withdrawalLeg.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:44:22'!
test06CanGoFromDepositLegToWithdrawalLeg

	| senderAccount recipientAccount transference |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: senderAccount.
	
	transference := Transference register: 60 from: senderAccount to: recipientAccount.
	
	self assert: transference depositLeg equals: transference withdrawalLeg depositLeg.
	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:50:06'!
test07CannotTransferFromOneAccountToTheSame

	| senderAccount |
	
	senderAccount := ReceptiveAccount new.
	
	self
		should: [ Transference register: 60 from: senderAccount to: senderAccount. ]
		raise: Error
		withMessageText: 'Cannot transfer to the same account'.
	

	
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'MN 6/7/2025 17:57:37'!
test08CannotTransferNegativeValues

	| senderAccount recipientAccount |
	
	senderAccount := ReceptiveAccount new.
	recipientAccount := ReceptiveAccount new.
	
	self
		should: [ Transference register: -60 from: senderAccount to: recipientAccount. ]
		raise: Error
		withMessageText: 'Cannot transfer negative values'.
	

	
	! !
