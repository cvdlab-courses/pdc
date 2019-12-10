# Parallel and Distributed Computing  (Computational Sciences & Computer Engineering)

## ABACUS 2019/20 (IN480)

### Teachers

*	[Alberto Paoluzzi](http://paoluzzi.dia.uniroma3.it), 

## Course Description, Goals and Objectives

This course introduces to techniques of parallel and  distributed computing, and to hardware and software architectures for high-performance scientific and technical computing. Some space will be given to iterative distributed methods for simulation of numerical problems, and to methods for assessment of very large geometric models and meshes. The programming launguage used is [_Julia_](http://julialang.org), novel dynamic language for scientific computing. Specific learning goals are:

1. Solve compute-intensive problems faster;
2. Solve larger problems in the same amount of time;
3. Solve same size problems with higher accuracy in the same amount of time.

## Course program

Brief introduction to Julia language. Introduction to parallel architectures, Parallel and distributed programming with Julia. Primitives of communication on synchronization. Languages based on directives. Performance metrics. Matrix operations and dense linear systems. Sparse linear systems. Collaborative development of projects.

## Programming language

[http://julialang.org](http://julialang.org)

"_Julia_ is a high-level, high-performance dynamic programming language for technical computing, with syntax that is familiar to users of other technical computing environments."

## Computational resources

Access will be granted to computational resources, including a DGX-1 superserver.

## Teaching materials

#.	[Lecture slides](lectures/)
#.	McCool, Reinders, and Robison, [*Structured Parallel Programming*: Patterns for Efficient Computation](https://www.amazon.com/Structured-Parallel-Programming-Efficient-Computation/dp/0124159931), Morgan Kaufmann, 2012
#. Avik Sengupta, [*Julia High Performance*: Optimizations, distributed computing, multithreading, and GPU programming with Julia 1.0 and beyond, 2nd Edition](https://juliahighperformance.com), Pakt>, 2019 
#. Ivo Balbaert and Adrian Salceanu, [*Julia 1.0 Programming, Complete Reference Guide*](https://www.amazon.it/Julia-Programming-Complete-Reference-Guide/dp/1838822240/ref=tmm_other_meta_binding_swatch_0?_encoding=UTF8&qid=&sr=)


## Schedule and materials

### October 2019

| # | date | arguments | category |
|--:|------|-----------|----------|
| 1 | Tue 01 | [Introduction to MarkDown and Git](lectures/2019-10-01/) | Programming |
| 2 | Wed 02 | [Basic Julia](lectures/2019-10-02/) | Programming |
| 3 | Mon 07 | [Basic Julia & project infos](lectures/2019-10-07/) | Language & Project |
| 4 | Tue 08 | [Basic Math Recall](lectures/2019-10-08/) | Math |
| 5 | Wed 09 | [Basic Julia & project infos](lectures/2019-10-09/) | Language & Project |
| 6 | Mon 14 | [Intro to Parallel Computation](lectures/2019-10-14/) | Theory |
| 7 | Tue 15 | [Analysis of course project](lectures/2019-10-15/) | Project |
| 8 | Wed 16 | [Course project scan](lectures/2019-10-16/) | Project |
| 9 | Mon 21 | [Parallel patterns & Arrangement pipeline](lectures/2019-10-21/) | Theory & Project |
| 10 | Tue 22 | [Data patterns & Symmetry + bound.compat.](lectures/2019-10-22/) | Theory & Project |
| 11 | Wed 23 | [Coroutines + debug code](lectures/2019-10-23/) | Theory & Project |
| 12 | Mon 28 | [Julia Timing and profiling](lectures/2019-10-28/) | Julia Programming |
| 13 | Tue 29 | [Julia types and single dispatching](lectures/2019-10-29/) |Julia Programming |
| 14 | Wed 30 | [Fast function calls & macros](lectures/2019-10-30/) |Julia Programming & Project|

### November 2019

| # | date | arguments | category |
|--:|------|-----------|----------|
| 15 | Tue 05 | [Exercise](lectures/2019-11-05/) |projects, Q&A |
| 16 | Wed 06 | [Exercise](lectures/2019-11-06/) |projects, Q&A|
| 17 | Mon 11 | [Program A](lectures/2019-11-11/) | projects, Q&A |
| 18 | Tue 12 | [Program B](lectures/2019-11-12/) | new projects |
| 19 | Wed 13 | [Program B](lectures/2019-11-13/) | new projects |
| 20 | Mon 18 | [Program C](lectures/2019-11-18/) | new projects |
| 21 | Tue 19 | [Julia tasks + Concurrent programming](lectures/2019-11-19/) | new projects |
| 22 | Wed 20 | [Paaa](lectures/2019-11-/) | aaaa |

| 23 | Mon 25 | [Molecular dynamics](lectures/2019-11-25/) | Theory & Project |
| 24 | Tue 26 | [Tasks](lectures/2019-11-26/) | Julia Programming |
| 25 | Wed 27 | [Threads](lectures/2019-11-27/) | Julia Programming |


### December 2019

| # | date | arguments | category |
|--:|------|-----------|----------|
| 26 | Mon 2 | [Best practices](lectures/2019-12-02/) | Julia Programming |
| 27 | Tue 3 | [Task-based concurrency](lectures/2019-12-03/) | Julia Programming |
| 28 | Wed 4 | [Distributed parallelism](lectures/2019-12-04/) | Julia Programming |
| 29 | Mon 9 | [Shared & distributed arrays](lectures/2019-12-09/) | Julia Programming |
| 30 | Tue 10 | [Parallelizable tasks](lectures/2019-12-10/) | Project A |

<!-- 
| 2 | Thu 27 | [Basic Julia](lectures/2018-09-27/) | Language |


### October 2018

| # | date | arguments | category |
|--:|------|-----------|----------|
| 3 | Tue 2 | [Assignment of course projects](lectures/2018-10-02/) | Projects |
| 4 | Thu 4 | [Assignment of course projects](lectures/2018-10-04/) | Projects |
| 5 | Tue 9 | [Parallel architectures](lectures/2018-10-09/) | Theory |
| a | Wed 10 | [Workshop 1](workshops/workshop1/) | Variables, types and functions |
| 6 | Thu 11 | [Parallel terminology](lectures/2018-10-11/) | Theory + Programming |
| - | Tue 16 | [No lecture]() | --- |
| - | Thu 18 | [No lecture]() | --- |
| 7 | Tue 23 | [B-spline curves](lectures/2018-10-23/) | Programming |
| b | Tue 23 | [Workshop 2](workshops/workshop2/) | Storage: Arrays and Tuples |
| 8 | Thu 25 | [Parallel Julia](lectures/2018-10-25/) | Programming |
| - | Tue 30 | [No lecture]() | --- |

### November 2018

| # | date | arguments | category |
|--:|------|-----------|----------|
| 9 | Tue 13 | [Parallel programming models](lectures/2018-11-13/) | Theory |
| 10 | Thu 15 | [Parallel algorithm design](lectures/2018-11-15/) | Theory |
| 11 | Tue 20 | [Sparse matrices](lectures/2018-11-20/) | Programming |
| 12 | Thu 22 | [Student works]() | Projects |
| 13 | Tue 27 | [Computing with sparse matrices ](lectures/2018-11-27/) | Programming |
| 14 | Thu 29 | [Test Driven Development ](lectures/2018-11-29/) | Programming |
 -->

<!-- 


### December 2018

| # | date | arguments | category |
|--:|------|-----------|----------|
| 15 | Tue 4 | [Basic Linear Algebra Sistems](lectures/2018-12-04/) | Programming |


 -->
 


<!-- to be used as an exmaple
### March 2017

| # | date | arguments | category |
|--:|------|-----------|----------|
| 1 | Mon  6 | [Introduction to Julia](lessons/2017-03-06/lecture-01.pdf) | Programming |
| 2 | Wed  8 | [Overview of parallel computing](lessons/2017-03-08/lecture-02.pdf) | Theory |
| 3 | Mon  13 | [Git & GitHub, Julia packages](lessons/2017-03-13/lecture-03.pdf) | Programming |
| 4 | Wed 15 | [Concepts and Terminology](lessons/2017-03-15/lecture-04.pdf) | Theory |
| 5 | Mon 20 | [Parallel Architectures and Programming Models](lessons/2017-03-20/) | Theory |
| 6 | Wed 22 | x | Practice |
| 7 | Mon 27 | [Parallel Programming in Julia](lessons/2017-03-27/) | Programming |
| 8 | Wed 29 | [Parallel Programming in Julia](lessons/2017-03-29/) | Theory |
-->
