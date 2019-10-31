% Parallel and Distributed Computation (IN480)
% First Homework
% \today

#.	Get a source file `2019-10-30/test-01.jl` from course repository.

#.	Look and execute. It should finish normally.

#.	Then change `n = 10 -> n = 3`. 
The program should again execute normally and terminate.

#.	Finally change `n = 3 -> n = 12`. 
The program should loop and not terminate. Stop it.

#.	Look for the statement going to loop.

#.	Start **debugging** by following the function calls.

#.	On the way try **optimizing / rewriting** some code, according to the 
techniques learned on the **first 4 chapters** of the book
[*Julia High Performance*: Optimizations, distributed computing, multithreading, 
and GPU programming with Julia 1.0 and beyond, 2nd 
Edition](https://juliahighperformance.com), Pakt>, 2019.
 
#.	**Document your changes** by writing a *markdown* document, including
`btime` statistics.  (use [*Pandoc*](https://pandoc.org) on markdown file)


#.	**Email** the document to me by *November 11*, according to the following format:

>>>>

	To: apaoluzzi@gmail.com
	Title: [IN480] Homework 1
	Contents:

	<url of your repo> (your forked module, with modified code)

	<your family name>-homework-1.pdf   

