"
# Hamming

Calculate the Hamming Distance between two DNA strands.

Your body is made up of cells that contain DNA. Those cells regularly wear out and need replacing, which they achieve by dividing into daughter cells. In fact, the average human body experiences about 10 quadrillion cell divisions in a lifetime!

When cells divide, their DNA replicates too. Sometimes during this process mistakes happen and single pieces of DNA get encoded with the incorrect information. If we compare two strands of DNA and count the differences between them we can see how many mistakes occurred. This is known as the ""Hamming Distance"".

We read DNA using the letters C,A,G and T. Two strands might look like this:

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

They have 7 differences, and therefore the Hamming Distance is 7.

The Hamming Distance is useful for lots of things in science, not just biology, so it's a nice phrase to be familiar with :)

# Implementation notes

The Hamming distance is only defined for sequences of equal length, so
an attempt to calculate it between sequences of different lengths should
not work. The general handling of this situation (e.g., raising an
exception vs returning a special value) may differ between languages.

## Hint

In Smalltalk, exceptions are instances of subclasses of Exception. While you can create your own for your domain, if you browse this hierarchy you can choose something appropriate to simplify your solution.

"
Class {
	#name : #HammingTest,
	#superclass : #ExercismTest,
	#instVars : [
		'hammingCalculator'
	],
	#category : #'Exercism-Hamming'
}

{ #category : #config }
HammingTest class >> core [
	"Answer a Boolean, true if this is a core exercise"
	
	^true
]

{ #category : #config }
HammingTest class >> difficulty [
	"Answer an Integer, the difficulty level of the test, 1=easy, 10=hard"
	
	^1
]

{ #category : #helper }
HammingTest class >> followedBy [
	"Answer the String name of the next core exercise that follows, otherwise nil if nothing comes after.
	
	This data provides a hook for users to load the next core exercise"
	
	^'Raindrops'
]

{ #category : #config }
HammingTest class >> topics [
	"Answer a String Array of topics that classify the exercise.
	Topics are commonly found in (but not limited to): 
		https://github.com/exercism/problem-specifications/blob/master/TOPICS.txt"

	^ #('equality' 'loops' 'strings' 'conditionals')
]

{ #category : #config }
HammingTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^nil
]

{ #category : #config }
HammingTest class >> uuid [
	"Answer a unique id for this exercise"
	^'69f615da-2b3f-0d00-a2ed-aca409f0590c'
]

{ #category : #config }
HammingTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.3.0'
]

{ #category : #setup }
HammingTest >> setUp [
	hammingCalculator := Hamming new
]

{ #category : #test }
HammingTest >> should: aBlock raise: anException containing: aMessageString [

	self
		should: aBlock
		raise: anException 
		withExceptionDo: [ :ex |
			self assert: ex messageText equals: aMessageString ]
		
		
]

{ #category : #test }
HammingTest >> testDisallowFirstStrandLonger [
	
	self
		should: [ hammingCalculator distanceStrand1: 'AATG' strand2: 'AAA' ]
		raise: Exception
		containing: 'left and right strands must be of equal length'
		
]

{ #category : #test }
HammingTest >> testDisallowLeftEmptyStrand [

	self
		should: [ hammingCalculator distanceStrand1: '' strand2: 'G' ]
		raise: Exception 
		containing: 'left strand must not be empty'
]

{ #category : #test }
HammingTest >> testDisallowRightEmptyStrand [
	
	self
		should: [ hammingCalculator distanceStrand1: 'G' strand2: '' ]
		raise: Exception
		containing: 'right strand must not be empty'
]

{ #category : #test }
HammingTest >> testDisallowSecondStrandLonger [

	self
		should: [ hammingCalculator distanceStrand1: 'ATA' strand2: 'AGTG' ]
		raise: Exception
		containing: 'left and right strands must be of equal length'
]

{ #category : #test }
HammingTest >> testEmptyStrands [
	| result |

	result := hammingCalculator distanceStrand1: '' strand2: '' .
	self assert: result equals: 0
]

{ #category : #test }
HammingTest >> testLongDifferentStrands [
	| result |

	result := hammingCalculator distanceStrand1: 'GGACGGATTCTG' strand2: 'AGGACGGATTCT' .
	self assert: result equals: 9
]

{ #category : #test }
HammingTest >> testLongIdenticalStrands [
	| result |

	result := hammingCalculator distanceStrand1: 'GGACTGAAATCTG' strand2: 'GGACTGAAATCTG' .
	self assert: result equals: 0
]

{ #category : #test }
HammingTest >> testSingleLetterDifferentStrands [
	| result |

	result := hammingCalculator distanceStrand1: 'G' strand2: 'T' .
	self assert: result equals: 1
]

{ #category : #test }
HammingTest >> testSingleLetterIdenticalStrands [
	| result |

	result := hammingCalculator distanceStrand1: 'A' strand2: 'A' .
	self assert: result equals: 0
]