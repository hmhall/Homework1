This project contains 3 scenes, corresponding with parts A, B, and C of the homework assignment. Press the numeral keys 1-3 to switch between the scenes.
Scene 1: Each object has an animation and a different shader. From left to right:
   -The duck has a vertex displacement shader that moves each of its vertices whose y position in world coordinates are >1 to the right.
   -The monitor has a phong shader that applies a plaid texture in different ways depending on the local position of each fragment. On one half, it is added to the lighting. On one quarter it is multiplied by the lighting. On one quarter it is subtracted from the lighting. 
   -The vending machine has a phong shader that sets the alpha value of any fragment with an r value above a certain threshold to 0. 
The scene also includes three lights:
   - A green directional light that spins and affects the monitor
   - A red spotlight that rotates up and down and affects the vending machine
   - A blue point light that affects nothing and can only be seen in the editor

Scene 2: The image of Jack Black has a blur filter. Press the right arrow to increase the blur effect (it must be pressed multiple times and cannot be held down). Press the left arrow to decrease the blur effect. 

Scene 3: This cellular automata has an added third color which wars against the green. It cannot reproduce on its own but can convert green, depending on how many green are adjacent versus how many other reds. This scene is bugged in the executable but runs fine in the editor. 
