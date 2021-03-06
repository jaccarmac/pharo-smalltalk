"
Exercism menu items that should only appear on a package tag 
"
Class {
	#name : #ClyExercismExerciseCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismExerciseCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^1
]

{ #category : #testing }
ClyExercismExerciseCommand class >> isAbstract [
	
	^self == ClyExercismExerciseCommand
]

{ #category : #activation }
ClyExercismExerciseCommand class >> tagContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: ClyTaggedClassGroup asCalypsoItemContext
]

{ #category : #execution }
ClyExercismExerciseCommand >> reportError: anError for: exerciseId [
	| msg |

	msg := exerciseId
		ifNil: [ anError messageText, '!' ]
		ifNotNil: [ 
			((Smalltalk hasClassNamed: exerciseId kebabAsCamelCase)
				ifTrue:
					[ 'Exercise "{1}" is missing metadata! You need to upgrade it in Exercism and re-fetch!' ]
				ifFalse:
					[ 'Exercise "{1}" not found! Please check the Exercism website for valid exercises!' ])
				format: {exerciseId} ].

	^ UIManager default abort: msg
]
