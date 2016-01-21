# Farkle
App to replicate the game "Farkle"


Collaborators: Christopher Erdos, Jon Jones

Week 2 app for Mobile Makers iOS Bootcamp.

Instructions:
  
      MVP
      1. As a user, I would like to have dice
      Create a new project called “Farkle”
      
      Create a subclass of UILabel called “DieLabel”
      2. As a user, I want to view 6 dice
      Add a UILabel to the ViewController in your Storyboard
      
      hint: Make sure you check User Interaction Enabled on all of your labels
      
      hint: This is not the same checkbox as the Enabled one!
      
      Change the label’s class to DieLabel
      
      Set the label’s text to 1.
      
      Change the background color of the DieLabel so that it’s easier to see
      
      Create a method to handle what happens when a DieLabel is clicked.
      
      hint: To begin with, have the method simply NSLog some information specific to the DieLabel.  Refine this behavior in later iterations.
      
      Programmatically add a UITapGestureRecognizer to the dieLabel in viewDidLoad.
      
      First implement the initWithCoder method.  The template for this method is as follows:
      
          - (id) initWithCoder:(NSCoder *)aDecoder {
      
                 self = [super initWithCoder:aDecoder];
      
              // add code here
      
                  return self
      
      }
      
      Create a UITapGesture object in the initWithCoder method and set the action to the method you created earlier
      Repeat this story 5 times more so you have a total of 6 dice on the screen
      
      3. As a user, I want to roll a die
      Add a - (void)roll method to your DieLabel class
      
      hint: Both .h and .m, it’s a public method!
      
      In your implementation, set the label’s text to a random number between 1 and 6.
      4. As a user, I want to roll all the dice
      Add a button to your ViewController scene titled “Roll”
      
      Hook it up to the onRollButtonPressed: action
      
      In onRollButtonPressed’s method body, call the roll method on each DieLabel in your ViewController
      
      hint: You can fast enumerate through your IBOutletCollection of labels
      5. As a user, I want to select dice to roll again
      The goal is that after the first roll, selected dice are held -- that is -- NOT rolled again. Don’t forget to clean up your previously touched dice between rolls. Remember, the first roll rolls all the dice!
      
      Create a protocol “DieLabelDelegate”
      
      Add a method declaration to the DieLabelDelegate protocol by adding it to your angular brackets in your ViewController.m and implementing the methods that XCode warns you aren’t implemented.
      
      Add a NSMutableArray property to your ViewController called “dice”
      
      Add a property to DieLabel called delegate of type id<DieLabelDelegate>
      
      Set the delegate properties of all the DieLabels to the ViewController instance.
      
      hint: self
      
      When the DieLabel is tapped, call the delegate-protocol method on the DieLabel’s delegate property
      
      hint: You write this code in DieLabel.m
      
      In your DieLabelDelegate protocol method implementation add the DieLabel instance to yourdice array
      
      When roll is pressed, only call roll on the DieLabels not in the dice array.
      
      hint: When dice are pressed, change their background colors to indicate that they won’t be rolled next time
      
      hint: If you hooked the roll button up to all six roll methods on all six of your DieLabels, then you will now have to rethink that…
      
      6. As a user, I want to play a round a Farkle
      Add a UILabel to track the user’s score to the ViewController scene in the storyboard
      
      Hook this label up to an outlet in ViewController.m and name it “userScore”
      
      Now it’s time to implement the Farkle game rules. Have fun! Challenge yourself! There are many variations of Farkle rules, but implement these standard ones.
      
      First turn: Roll all of the dice,
      
      After each roll, set aside one or more dice (See scoring section)
      
      Second turn: Roll again or bank score
      
      If all dice have scored, player has “hot dice” and gets to roll all six dice again
      
      If no dice have scored, player has “farkled” and the turn is over
      
      Three 1’s = 1,000
      
      Three 2’s = 200
      
      Three 3’s = 300
      
      Three 4’s = 400
      
      Three 5’s = 500
      
      Three 6’s = 600
      
      7. As a user, I want to make the game a little more difficult
      Each scoring combination must be achieved in a single throw. For example, if a player has already set aside two individual 1s and then throws a third with the four dice remaining, they do not have a triplet of 1s for a score of 1000.
      8. As a user, I want to be able to score individually for 1’s and 5’s
      Add code to your game to allow a user to also score for a single 1 or 5.
      
      Note: If a user sets aside three 1’s in the same roll, they do not receive 100 points for each 1, only the 1,000 points for the triplet. The same applies to setting aside three 5’s.
      
      Each 1 = 100 points
      
      Each 5 = 50 points
      9. As a user, I want to play this game against another user
      Add a button to indicate when a turn is finished and points should be gathered
      Add a second label to keep score between the two players
      
      10. It changes the background color if you select more then one person it is clearer that you have done so
      11. Add an ‘I’M Done! Point Me!’ button
      The button should allow the user to collect points and move to the next player
      
      12. Add a alert with the score from the round and for the game
      Give the user a ‘Alert - OK button’ that says ‘You scored 200 in this round.   Your total for the game is: 450
      
      STRETCH
      STRETCH 1. As a user, I want to gather the dice to a single location using animation, and then see them fan out when a roll occurs using a similar animation
      Create a label that will be used to “gather dice”.  Make sure User Interaction Enabled is checked in StoryBoard
      
      Programmatically attach a UITapGestureRecognizer in viewDidLoad with an appropriate method you define as the action
      
      Create a UIDynamicAnimator property that will be used to animate the dice being gathered and rolled
      
      Create a UISnapBehavior and apply this object to the UIDynamicAnimator property
      
      STRETCH 2. As a user, I want to animate the gathering/rolling of dice that are not yet selected. Selected dice should stay in place.
      Create six CGPoints that represent a default point for each of the dice.
      
      Hint: The decision you make to use a dictionary or array to store these points can impact how elegant this step is implemented.  Alternatively you can store these points as individual properties if it helps you reason about how to code this step.
      
      Hint: Because CGPoints are not objects, you need to convert them to NSValues when adding them to either the dictionary or array.  
      
      Hint: When retrieving NSValues from the dictionary or array, you will have to reconvert them back into CGPoints.
      
      Create a method that will manage whether or not a DieLabel is to be animated.  
      
      Hint: You cannot reuse a single UISnapBehavior object.  Whenever a user gathers the dice, only the dice that are not selected should animate inward upon gathering, and similarly fan outwards upon rolling.  The die that have been selected (or are out of play for the turn) should remain stationary.
      
      Ensure that the die that are selected somehow change color (either background or text)
      STRETCH 3. As a user, I want to see actual dice images instead of numbers.
      Find six images that represent the six sides of a die.
      
      Save these images to your computer and rename them appropriately.
      
      Drag and drop these images into the Images.xcassets folder.
      
      Google NSTextAttachment and see how it can be used to add an image to a UILabel.
      
      hint: Research NSAttributedString and see how it can be used to attach an image to aUILabel.
      
      hint: Try to organize your code for “upgradeability”
      
      Create a method in the DieLabel object that takes as an input parameter the number which represents any given die’s value.  This method should contain logic to set the label’s image to it’s current value.
      STRETCH 4. As a user, I want to see the inverse image when a die is selected.
      Modify the method that is used to attach an image to a UILabel.
      
      hint: Simply invert the image!  Your laptops already have the software, some Googling will give you the answer.
      
      hint: Update the method from Step 12 used to attach an image to a UILabel.
      
      STRETCH 5. As a user, I want to see the dice return to a default position when my turn is over and another player’s turn begins.
      Whenever a player’s turn begins, reset the position of each die to the default points for each die in the array
