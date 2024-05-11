# Description

Choosen Programming langugages are Python and Haskell for Imperative and Functional Programming Paradigms. The project converts an Image to a ASCII character. The image used for this example has a filename 12.jpeg. It's a picture of Nikola Tesla. The Python and the Haskell script converts the image to a ascii character and prints the results in the terminal.

# Requirements/Commands
Requires python 3.x
Python:
```
python Image_text.py
```
You should see the below output in your terminal 

Haskhell:
Requires Haskell instead and running. For MacOS or Linux you can run the below command in your terminal to install haskell 

 ` curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh `
 
Make sure you're inside the image-to-text directory 
```
stack build
stack exec image-to-text-exe
```
You should see the below output in your termianl 
# Explanation/Comparison

concept #1  
Imperative vs. Functional - Python uses imperative programming style, which focuses on achieveing the ASCII conversion step by step using loops and mutable state. Haskell, on the other hand, is functional, which focuses on what needs to be done by composing functions and avoiding mutable state. Haskell relies mainly on functions and recurion to transform the image to ASCII. 

concept #2
In python, it allows to print directly within functions. However, in haskell it does not directly print, it return the ASCII art as a string.Python uses eager evaluation, meaning expressions are evaluated when they're encountered. Haskell uses lazy evaluation, meaning expressions are evaluated only when their results are actually needed. This can lead to more efficient use of resources in some cases, as only the necessary parts of the computation are evaluated.

concept #3
Python is dynamically typed, meaning types are inferred at runtime. This allows for more flexibility but can lead to runtime errors if types don't match. Haskell is statically typed, meaning types are checked at compile time. This can catch many errors before the program is run, leading to more robust code.
