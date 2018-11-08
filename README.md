## Elevator

clone this repro

[elevator on github](https://github.com/troyleach/elevator)

ruby version ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-darwin14]

### Flow

Turn on sound

#### To start:

`cd into elevator folder`

`ruby controller/elevator.rb`

- No harsh moves wait for the command prompt to act

```bash
q: quit (press return key), number (press return key), c: close door (press return key)
Command =>
```

- To start just type the floor you are starting on (1 - 10)
- After you typed a number (1-10) hit the return key'
- wait for the cab to arrive
- then you will see something like:

```bash
q: quit (press return key), number (press return key), c: close door (press return key)
Command =>  5
5
Doors opening
...Exiting
(U) UP
(D) DOWN
Command =>
```

- Now select 'u' or 'd' the direction you wish to go in and hit the return key.
- Then you should see something like

```bash
Command =>  u
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "c"]
q: quit (press return key), number (press return key), c: close door (press return key)
Command =>
```

- The numbers represent the button floor numbers and the `c` represents `close doors`
- Type as many floors as you want. Just remember to hit the return key after each selection.
  > A better design might be to ask the user to select the floors separated by commas. I have
  > always felt it to be a challenge to collect user input. `1,4,6`. No matter how
  > clear I think it is, somebody wont get it. (I mean that in the nicest of ways (#raul))
- then type 'c' and hit return"

```bash
Command =>  u
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "c"]
q: quit (press return key), number (press return key), c: close door (press return key)
Command =>  5
Command =>  3
Command =>  5
Command =>  c
```

- This will close the doors and you will be on your way
- Set back and enjoy the ride
- Type 'q' at any time to exit this program"

### Design

There are a lot of different ways to design this. Also one could code for days and days. From my research on modeling elevators, while may look and seem straight forward it actually is really complex.

To time box what I wanted to get done the basic flow is as follows.

You select a starting floor

The cab is then called to that floor

If on the 1 first or last floor the priority direction is either up (for 1) or down (for last floor) and the cab will continue in that direction until the Q is empty then it will check to see if the opposite direction Q has stops and act accordingly.

Obviously at each stop people can get on and push buttons. While I feel the software can handle this I did not incorporate this into the design.

How I determined priority direction was based on the buttons that were pushed. If passenger was on 1st floor the priority direction was up, if the last floor the priority direction was down. If the passenger was on a middle floor, if up was pushed then up was the priority direction and if down was pushed then down was the priority direction.

`elevator.rb` is the controller of the program. Manages the Q and can delegate requests to one or many cabs.

### Data Structure

I used a priority queue. I wanted to use only one. But it seemed easier to have two even with more code. It worked best for me.

### Test

To run test
`rspec`

### Design notes and things

I included some design notes, image, and pseudocode. I really tried to be very
transparent in my thought process

notes and images:
Inline-style:
![alt text](https://github.com/troyleach/elevator/design_sketch.jpg 'Logo Title Text 1')
Below is simple pseudocode:

```ruby
# Command line user
  # [] start the elevator
  # [] Tell the user how many floors in the building - welcome to Troy's Tower
  # [] Tell the elevator where you are
  # [] can make several button calls? figure this out
  # [] Once all buttons have been pushed tell elevator to go

  # Start the elevator
    # [] Cab will start on the 4th floor
    # [] start on the first floor
    # [] user pushes the up button
    # [] makes request for cab
    # [] watch the elvator come down (display, not a big deal to have this)
    # [] the doors will open
    # [] then display the elvator cab buttons
      # [] tell the user they can select as many buttons as they wish (pretending that there are a lot of peeps in the cab)
      # [] assuming no weight limit
      # [] then push door close button
    # [] doors will close
    # [] elevator will drop people off at the floors they need to go to in priorty
    # [] once the last person is off (q is empty)

# TODO - maybe I can have a method called floor. user can type something like
  # floor(1,up) - this would make a request stating, request is coming from floor 1
  # and they want to go up

  # Process starting point
    # [] user can pick witch floor they want to start from again
    # [] depending on where they start display the right hall buttons.
      # [] depending on witch button is selected (up or down, say up) then that is the priorty direction
      # [] if on floor 5 - up button is selected
      # [] floors 2, 1, 6, 4. then the close door button is selected
      # [] UP is priorty
      # [] drop off is in this order:
       # [] UP floor 6,
       # [] then DOWN to floor 4,
       # [] then floor 2,
       # [] then floor 1
       # [] idle
    # then repeat process until quit
```

### References

[elevator on wiki](https://en.wikipedia.org/wiki/Elevator)

[Priority queue](https://rosettacode.org/wiki/Priority_queue#Ruby)
