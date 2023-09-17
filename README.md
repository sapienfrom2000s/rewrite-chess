Use w-s-a-d to move and 'enter' to select and move pieces.

New features:
Queen-side castling possible by pressing 'q'.
King-side castling possible by pressing 'k'.
Exit anytime out of the game by pressing 'e'.
Promotion feature is also available.

To Do:
[ ] Add En passent feature

Use of 'coordinates' and 'squares' are synonymous. For display
squares has been used and in other places coordinates have
been used. However, this is not very black and white, 'squares'
might have been used at places where it fits in more appropriately
than 'coordinates'.

This project is inspired by Haseeb Qureshi's version of chess.
https://github.com/Haseeb-Qureshi/Ruby-Chess

Learnings:

This project was huge. Organizing it and making design choices
was the hard part. I messed it the first time I tried it.
https://github.com/sapienfrom2000s/chess
TDD wasn't followed in this project as I was too lazy to do
it. I also didn't have a clear picture about the benefits of
TDD. Tests were write after adding features.
Inheritance is powerful.The common properties can be pushed to
parent, it helps to keep the code dry.Single responsibility principle.
I am not sure if I followed it, but the idea is to split responsibilities
bw classes as much as possible.
Using script to open the program instead of manually telling it to
interpret it with ruby again and again. Used LOAD_PATH to require
files from lib instead of require_relative
Powerful git ideas such as hard reset, rebasing and applying patches.
Design patterns such as loosely coupled code and dependency injection

