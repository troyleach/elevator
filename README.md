## Elevator

clone this repro

[elevator on github](https://github.com/troyleach/elevator)

ruby version ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-darwin14]

To start type: `ruby controller/elevator.rb` into the command line

- Turn on sound
- No harsh moves wait for the command prompt to act

```bash
q: quit (press return key), number (press return key), c: close door (press return key)
Command =>
```

- To start just type the floor you are starting on (1 - 10)'
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
  > always felt it to be a challenge to collect user input. `1,4,6`
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

- This will close the doors and you will be on your way'
- Set back and enjoy the ride
- Type 'q' at any time to exit this program"

### Design

There are a lot of different ways to design this. Also one could code for days and days. From my research on modeling elevators, while may look and seem straight forward it actually is really complex.

To time box what I wanted to get done the basic flow is as follows.

- You select a starting floor
- The cab is then called to that floor
- if you are on the 1 first or last floor the priority direction is either up (for 1) or down (for last floor) and the cab will continue in that direction until the Q is empty then it will check to see if the opposite direction Q has stops and act accordingly.
- Obviously at each stop people can get on and push buttons. While this can handle this I did not code this in.
- How I detirmend proprity direction was but the buttons that were pushed. If passenger was on 1st floor the priority direction was up, if the last floor the priority direction was down. If the passenger was on a middle floor, if up was pushed then up was the priority direction and if down was pushed then down was the priority direction.

NOTES:

- look for a return ascii symbole
