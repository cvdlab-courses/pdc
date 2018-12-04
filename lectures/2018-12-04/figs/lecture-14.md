% Parallel \& Distributed Computing: Lecture 14
% Alberto Paoluzzi
% \today
\tableofcontents

<!-- ============================================================= -->
#	Basic Linear Algebra Subprograms (BLAS)
<!-- ============================================================= -->


<!-- ------------------------------------------------------------- -->
##	Introduction
<!-- ------------------------------------------------------------- -->


The **BLAS** (Basic Linear Algebra Subprograms) are *routines* that provide **standard building blocks** for performing *basic vector and matrix operations*. 

Level 1 BLAS
:	performs *scalar*, *vector* and vector-vector operations, 

Level 2 BLAS
:	performs *matrix-vector* operations, and 

Level 3 BLAS
:	performs *matrix-matrix* operations. 

Because the BLAS are *efficient*, *portable*, and widely available, they are commonly used in the *development of high quality* l**inear algebra software**, LAPACK for example.

<!-- ------------------------------------------------------------- -->
##	History
<!-- ------------------------------------------------------------- -->

They are the **de facto standard** *low-level routines* for **linear algebra libraries**; the routines have *bindings* for both *C* and *Fortran*. 

It *originated as a Fortran library* in 1979[1] and its interface was standardized by the BLAS Technical (BLAST) Forum, whose latest BLAS report can be found on the [*netlib*](http://www.netlib.org) website. This Fortran library is known as the **reference implementation**

Most libraries that offer linear algebra routines *conform to the BLAS interface*, allowing library users to develop programs that are *agnostic* of the BLAS library being used.

**OpenBLAS** is an open-source library that is *hand-optimized* for many of the popular architectures. 

The [*LINPACK benchmarks*](https://www.top500.org/project/linpack/) rely heavily on the BLAS routine *`gemm`* for its **performance measurements**.

<!-- ------------------------------------------------------------- -->
##	Level 1:  SINGLE
<!-- ------------------------------------------------------------- -->
\small

-   [*SROTG*](http://www.netlib.org/lapack/explore-html/d7/d26/srotg_8f.html) -
	setup Givens rotation
-   [*SROTMG*](http://www.netlib.org/lapack/explore-html/dd/d48/srotmg_8f.html) -
	setup modified Givens rotation
-   [*SROT*](http://www.netlib.org/lapack/explore-html/db/d6c/srot_8f.html) -
	apply Givens rotation
-   [*SROTM*](http://www.netlib.org/lapack/explore-html/d6/d0f/srotm_8f.html) -
	apply modified Givens rotation
-   [*SSWAP*](http://www.netlib.org/lapack/explore-html/d9/da9/sswap_8f.html) -
	swap x and y
-   [*SSCAL*](http://www.netlib.org/lapack/explore-html/d9/d04/sscal_8f.html) -
	x = a\*x
-   [*SCOPY*](http://www.netlib.org/lapack/explore-html/de/dc0/scopy_8f.html) -
	copy x into y
-   [*SAXPY*](http://www.netlib.org/lapack/explore-html/d8/daf/saxpy_8f.html) -
	y = a\*x + y
-   [*SDOT*](http://www.netlib.org/lapack/explore-html/d0/d16/sdot_8f.html) -
	dot product
-   [*SDSDOT*](http://www.netlib.org/lapack/explore-html/d9/d47/sdsdot_8f.html) -
	dot product with extended precision accumulation
-   [*SNRM2*](http://www.netlib.org/lapack/explore-html/d7/df1/snrm2_8f.html) -
	Euclidean norm
-   [*SCNRM2*](http://www.netlib.org/lapack/explore-html/db/d66/scnrm2_8f.html)-
	Euclidean norm
-   [*SASUM*](http://www.netlib.org/lapack/explore-html/df/d1f/sasum_8f.html) -
	sum of absolute values
-   [*ISAMAX*](http://www.netlib.org/lapack/explore-html/d6/d44/isamax_8f.html) -
	index of max abs value


<!-- ------------------------------------------------------------- -->
##	Level 1:  DOUBLE
<!-- ------------------------------------------------------------- -->
\small

-   [*DROTG*](http://www.netlib.org/lapack/explore-html/de/d13/drotg_8f.html) -
	setup Givens rotation
-   [*DROTMG*](http://www.netlib.org/lapack/explore-html/df/deb/drotmg_8f.html) -
	setup modified Givens rotation
-   [*DROT*](http://www.netlib.org/lapack/explore-html/dc/d23/drot_8f.html) -
	apply Givens rotation
-   [*DROTM*](http://www.netlib.org/lapack/explore-html/d8/d7b/drotm_8f.html) -
	apply modified Givens rotation
-   [*DSWAP*](http://www.netlib.org/lapack/explore-html/db/dd4/dswap_8f.html) -
	swap x and y
-   [*DSCAL*](http://www.netlib.org/lapack/explore-html/d4/dd0/dscal_8f.html) -
	x = a\*x
-   [*DCOPY*](http://www.netlib.org/lapack/explore-html/da/d6c/dcopy_8f.html) -
	copy x into y
-   [*DAXPY*](http://www.netlib.org/lapack/explore-html/d9/dcd/daxpy_8f.html) -
	y = a\*x + y
-   [*DDOT*](http://www.netlib.org/lapack/explore-html/d5/df6/ddot_8f.html) -
	dot product
-   [*DSDOT*](http://www.netlib.org/lapack/explore-html/dc/d01/dsdot_8f.html) -
	dot product with extended precision accumulation
-   [*DNRM2*](http://www.netlib.org/lapack/explore-html/da/d7f/dnrm2_8f.html) -
	Euclidean norm
-   [*DZNRM2*](http://www.netlib.org/lapack/explore-html/d9/d19/dznrm2_8f.html) -
	Euclidean norm
-   [*DASUM*](http://www.netlib.org/lapack/explore-html/de/d05/dasum_8f.html) -
	sum of absolute values
-   [*IDAMAX*](http://www.netlib.org/lapack/explore-html/dd/de0/idamax_8f.html) -
	index of max abs value

<!-- ------------------------------------------------------------- -->
##	Level 1:  Complex
<!-- ------------------------------------------------------------- -->
\small

-   [*CROTG*](http://www.netlib.org/lapack/explore-html/dc/de6/crotg_8f.html) -
	setup Givens rotation
-   [*CSROT*](http://www.netlib.org/lapack/explore-html/d1/dbb/csrot_8f.html) -
	apply Givens rotation
-   [*CSWAP*](http://www.netlib.org/lapack/explore-html/d1/d44/cswap_8f.html) -
	swap x and y
-   [*CSCAL*](http://www.netlib.org/lapack/explore-html/dc/d81/cscal_8f.html) -
	x = a\*x
-   [*CSSCAL*](http://www.netlib.org/lapack/explore-html/de/d5e/csscal_8f.html) -
	x = a\*x
-   [*CCOPY*](http://www.netlib.org/lapack/explore-html/d9/dfb/ccopy_8f.html) -
	copy x into y
-   [*CAXPY*](http://www.netlib.org/lapack/explore-html/de/da2/caxpy_8f.html) -
	y = a\*x + y
-   [*CDOTU*](http://www.netlib.org/lapack/explore-html/d7/d7b/cdotu_8f.html) -
	dot product
-   [*CDOTC*](http://www.netlib.org/lapack/explore-html/dd/db2/cdotc_8f.html) -
	dot product, conjugating the first vector
-   [*SCASUM*](http://www.netlib.org/lapack/explore-html/db/d53/scasum_8f.html) -
	sum of absolute values
-   [*ICAMAX*](http://www.netlib.org/lapack/explore-html/dd/d51/icamax_8f.html) -
	index of max abs value

<!-- ------------------------------------------------------------- -->
##	Level 1:  Double Complex 
<!-- ------------------------------------------------------------- -->
\small

-   [*ZROTG*](http://www.netlib.org/lapack/explore-html/dc/dfe/zrotg_8f.html) -
	setup Givens rotation
-   [*ZDROTF*](http://www.netlib.org/lapack/explore-html/d4/de9/zdrot_8f.html) -
	apply Givens rotation
-   [*ZSWAP*](http://www.netlib.org/lapack/explore-html/d3/dc0/zswap_8f.html) -
	swap x and y
-   [*ZSCAL*](http://www.netlib.org/lapack/explore-html/d2/d74/zscal_8f.html) -
	x = a\*x
-   [*ZDSCAL*](http://www.netlib.org/lapack/explore-html/dd/d76/zdscal_8f.html) -
	x = a\*x
-   [*ZCOPY*](http://www.netlib.org/lapack/explore-html/d6/d53/zcopy_8f.html) -
	copy x into y
-   [*ZAXPY*](http://www.netlib.org/lapack/explore-html/d7/db2/zaxpy_8f.html) -
	y = a\*x + y
-   [*ZDOTU*](http://www.netlib.org/lapack/explore-html/db/d2d/zdotu_8f.html) -
	dot product
-   [*ZDOTC*](http://www.netlib.org/lapack/explore-html/d6/db8/zdotc_8f.html) -
	dot product, conjugating the first vector
-   [*DZASUM*](http://www.netlib.org/lapack/explore-html/df/d0f/dzasum_8f.html) -
	sum of absolute values
-   [*IZAMAX*](http://www.netlib.org/lapack/explore-html/d0/da5/izamax_8f.html) -
	index of max abs value

<!-- ------------------------------------------------------------- -->
##	Level 2: DOUBLE
<!-- ------------------------------------------------------------- -->
\footnotesize

-   [*DGEMV*](http://www.netlib.org/lapack/explore-html/dc/da8/dgemv_8f.html) -
	matrix vector multiply
-   [*DGBMV*](http://www.netlib.org/lapack/explore-html/d2/d3f/dgbmv_8f.html) -
	banded matrix vector multiply
-   [*DSYMV*](http://www.netlib.org/lapack/explore-html/d8/dbe/dsymv_8f.html) -
	symmetric matrix vector multiply
-   [*DSBMV*](http://www.netlib.org/lapack/explore-html/d8/d1e/dsbmv_8f.html) -
	symmetric banded matrix vector multiply
-   [*DSPMV*](http://www.netlib.org/lapack/explore-html/d4/d85/dspmv_8f.html) -
	symmetric packed matrix vector multiply
-   [*DTRMV*](http://www.netlib.org/lapack/explore-html/dc/d7e/dtrmv_8f.html) -
	triangular matrix vector multiply
-   [*DTBMV*](http://www.netlib.org/lapack/explore-html/df/d29/dtbmv_8f.html) -
	triangular banded matrix vector multiply
-   [*DTPMV*](http://www.netlib.org/lapack/explore-html/dc/dcd/dtpmv_8f.html) -
	triangular packed matrix vector multiply
-   [*DTRSV*](http://www.netlib.org/lapack/explore-html/d6/d96/dtrsv_8f.html) -
	solving triangular matrix problems
-   [*DTBSV*](http://www.netlib.org/lapack/explore-html/d4/dcf/dtbsv_8f.html) -
	solving triangular banded matrix problems
-   [*DTPSV*](http://www.netlib.org/lapack/explore-html/d9/d84/dtpsv_8f.html) -
	solving triangular packed matrix problems
-   [*DGER*](http://www.netlib.org/lapack/explore-html/dc/da8/dger_8f.html) -
	performs the rank 1 operation A := alpha\*x\*y' + A
-   [*DSYR*](http://www.netlib.org/lapack/explore-html/d3/d60/dsyr_8f.html) -
	performs the symmetric rank 1 operation A := alpha\*x\*x' + A
-   [*DSPR*](http://www.netlib.org/lapack/explore-html/dd/dba/dspr_8f.html) -
	symmetric packed rank 1 operation A := alpha\*x\*x' + A
-   [*DSYR2*](http://www.netlib.org/lapack/explore-html/de/d41/dsyr2_8f.html) -
	performs the symmetric rank 2 operation, A := alpha\*x\*y' +
	alpha\*y\*x' + A
-   [*DSPR2*](http://www.netlib.org/lapack/explore-html/dd/d9e/dspr2_8f.html) -
	performs the symmetric packed rank 2 operation, A :=
	alpha\*x\*y' + alpha\*y\*x' + A


<!-- ------------------------------------------------------------- -->
##	Level 3: 
<!-- ------------------------------------------------------------- -->
\footnotesize

-   Single
    -   [*SGEMM*](http://www.netlib.org/lapack/explore-html/d4/de2/sgemm_8f.html) -
        matrix matrix multiply
    -   [*SSYMM*](http://www.netlib.org/lapack/explore-html/d7/d42/ssymm_8f.html) -
        symmetric matrix matrix multiply
    -   [*SSYRK*](http://www.netlib.org/lapack/explore-html/d0/d40/ssyrk_8f.html) -
        symmetric rank-k update to a matrix
    -   [*SSYR2K*](http://www.netlib.org/lapack/explore-html/df/d3d/ssyr2k_8f.html) -
        symmetric rank-2k update to a matrix
    -   [*STRMM*](http://www.netlib.org/lapack/explore-html/df/d01/strmm_8f.html) -
        triangular matrix matrix multiply
    -   [*STRSM*](http://www.netlib.org/lapack/explore-html/d2/d8b/strsm_8f.html) -
        solving triangular matrix with multiple right hand sides

-   Double
    -   [*DGEMM*](http://www.netlib.org/lapack/explore-html/d7/d2b/dgemm_8f.html) -
        matrix matrix multiply
    -   [*DSYMM*](http://www.netlib.org/lapack/explore-html/d8/db0/dsymm_8f.html) -
        symmetric matrix matrix multiply
    -   [*DSYRK*](http://www.netlib.org/lapack/explore-html/dc/d05/dsyrk_8f.html) -
        symmetric rank-k update to a matrix
    -   [*DSYR2K*](http://www.netlib.org/lapack/explore-html/d1/dec/dsyr2k_8f.html) -
        symmetric rank-2k update to a matrix
    -   [*DTRMM*](http://www.netlib.org/lapack/explore-html/dd/d19/dtrmm_8f.html) -
        triangular matrix matrix multiply
    -   [*DTRSM*](http://www.netlib.org/lapack/explore-html/de/da7/dtrsm_8f.html) -
        solving triangular matrix with multiple right hand sides

<!-- ------------------------------------------------------------- -->
##	Level 3: 
<!-- ------------------------------------------------------------- -->
\footnotesize

-   Complex
    -   [*CGEMM*](http://www.netlib.org/lapack/explore-html/d6/d5b/cgemm_8f.html) -
        matrix matrix multiply
    -   [*CSYMM*](http://www.netlib.org/lapack/explore-html/db/d59/csymm_8f.html) -
        symmetric matrix matrix multiply
    -   [*CHEMM*](http://www.netlib.org/lapack/explore-html/d3/d66/chemm_8f.html) -
        hermitian matrix matrix multiply
    -   [*CSYRK*](http://www.netlib.org/lapack/explore-html/d3/d6a/csyrk_8f.html) -
        symmetric rank-k update to a matrix
    -   [*CHERK*](http://www.netlib.org/lapack/explore-html/d8/d52/cherk_8f.html) -
        hermitian rank-k update to a matrix
    -   [*CSYR2K*](http://www.netlib.org/lapack/explore-html/de/d7e/csyr2k_8f.html) -
        symmetric rank-2k update to a matrix
    -   [*CHER2K*](http://www.netlib.org/lapack/explore-html/d1/d82/cher2k_8f.html) -
        hermitian rank-2k update to a matrix
    -   [*CTRMM*](http://www.netlib.org/lapack/explore-html/d4/d9b/ctrmm_8f.html) -
        triangular matrix matrix multiply
    -   [*CTRSM*](http://www.netlib.org/lapack/explore-html/de/d30/ctrsm_8f.html) -
        solving triangular matrix with multiple right hand sides

<!-- ============================================================= -->
#	Linear Algebra Package (LAPACK)
<!-- ============================================================= -->

<!-- ------------------------------------------------------------- -->
##	Introduction (from [*http://www.netlib.org/lapack/*](http://www.netlib.org/lapack/))
<!-- ------------------------------------------------------------- -->

LAPACK is written in *Fortran 90* and provides routines for **solving systems** of simultaneous linear equations, **least-squares solutions** of linear systems of equations, **eigenvalue** problems, and **singular value** problems. 

The associated **matrix factorizations** (*LU*, *Cholesky*, *QR*, *SVD*, *Schur*, generalized Schur) are also provided, as are related computations such as reordering of the Schur factorizations and estimating condition numbers. 

*Dense* and *banded* matrices are handled, but **not** general **sparse matrices**. 

In all areas, *similar functionality* is provided for **real** and **complex** matrices, in both **single** and **double** precision.

LAPACK routines are written so that as much as possible of the *computation* is performed *by calls to* the Basic Linear Algebra Subprograms (*BLAS*). 

LAPACK is *designed* at the outset to exploit the *Level 3 BLAS*

<!-- ------------------------------------------------------------- -->
##	LAPACK
<!-- ------------------------------------------------------------- -->

[*Release history*](http://www.netlib.org/lapack/#_release_history)

[*Related projects*](http://www.netlib.org/lapack/#_related_projects)



<!-- ------------------------------------------------------------- -->
##	LAPACK function naming scheme
<!-- ------------------------------------------------------------- -->

\footnotesize

The name of each LAPACK routine is a **coded specification** of its *function* (within the very tight limits of *standard Fortran 77* 6-character names).

All driver and computational routines have **names of the form XYYZZZ**, where for some driver routines the 6th character is blank.

The *first letter*, **X**, indicates the data type as follows:

S
:	REAL

D
:	DOUBLE PRECISION

C
:	COMPLEX

Z
:	COMPLEX*16 or DOUBLE COMPLEX

When we wish to refer to an LAPACK routine generically, regardless of data type, we replace the first letter by *x*. Thus xGESV refers to any or all of the routines SGESV, CGESV, DGESV and ZGESV.

The next two letters, **YY**, indicate the *type of matrix* (or of the most significant matrix). 

Most of these two-letter codes apply to both real and complex matrices; a few apply specifically to one or the other


<!-- ------------------------------------------------------------- -->
##	LAPACK matrix naming scheme
<!-- ------------------------------------------------------------- -->

\scriptsize

\columnsbegin
\column{.45\textwidth}

*	**BD**	bidiagonal
*	**DI**	diagonal
*	**GB**	general band
*	**GE**	general (i.e., unsymmetric, in some cases rectangular)
*	**GG**	general matrices, generalized problem (i.e., a pair of general matrices)
*	**GT**	general tridiagonal
*	**HB**	(complex) Hermitian band
*	**HE**	(complex) Hermitian
*	**HG**	upper Hessenberg matrix, generalized problem (i.e a Hessenberg and a
	 	triangular matrix)
*	**HP**	(complex) Hermitian, packed storage
*	**HS**	upper Hessenberg
*	**OP**	(real) orthogonal, packed storage
*	**OR**	(real) orthogonal

\column{.55\textwidth}

*	**PB**	symmetric or Hermitian positive definite band
*	**PO**	symmetric or Hermitian positive definite
*	**PP**	symmetric or Hermitian positive definite, packed storage
*	**PT**	symmetric or Hermitian positive definite tridiagonal
*	**SB**	(real) symmetric band
*	**SP**	symmetric, packed storage
*	**ST**	(real) symmetric tridiagonal
*	**SY**	symmetric
*	**TB**	triangular band
*	**TG**	triangular matrices, generalized problem (i.e., a pair of triangular matrices)
*	**TP**	triangular, packed storage
*	**TR**	triangular (or in some cases quasi-triangular)
*	**TZ**	trapezoidal
*	**UN**	(complex) unitary
*	**UP**	(complex) unitary, packed storage

\columnsend


<!-- ============================================================= -->
#	Julia's Linear Algebra
<!-- ============================================================= -->


<!-- ------------------------------------------------------------- -->
##	Standard Functions
<!-- ------------------------------------------------------------- -->

[*https://docs.julialang.org/en/stable/stdlib/linalg/#Standard-Functions-1*](https://docs.julialang.org/en/stable/stdlib/linalg/#Standard-Functions-1)

<!-- ------------------------------------------------------------- -->
##	Low-level matrix operations
<!-- ------------------------------------------------------------- -->

[*https://docs.julialang.org/en/stable/stdlib/linalg/#Low-level-matrix-operations-1*](https://docs.julialang.org/en/stable/stdlib/linalg/#Low-level-matrix-operations-1)

<!-- ------------------------------------------------------------- -->
##	BLAS functions
<!-- ------------------------------------------------------------- -->

[*https://docs.julialang.org/en/stable/stdlib/linalg/#BLAS-Functions-1*](https://docs.julialang.org/en/stable/stdlib/linalg/#BLAS-Functions-1)


<!-- ------------------------------------------------------------- -->
##	LAPACK functions
<!-- ------------------------------------------------------------- -->

[*https://docs.julialang.org/en/stable/stdlib/linalg/#LAPACK-Functions-1*](https://docs.julialang.org/en/stable/stdlib/linalg/#LAPACK-Functions-1)

<!-- ------------------------------------------------------------- -->
##	LAPACK functions list in Julia
<!-- ------------------------------------------------------------- -->

\tiny

\columnsbegin
\column{.33\textwidth}

Base.LinAlg.LAPACK.gbtrs!
Base.LinAlg.LAPACK.gebal!
Base.LinAlg.LAPACK.gebak!
Base.LinAlg.LAPACK.gebrd!
Base.LinAlg.LAPACK.gelqf!
Base.LinAlg.LAPACK.geqlf!
Base.LinAlg.LAPACK.geqrf!
Base.LinAlg.LAPACK.geqp3!
Base.LinAlg.LAPACK.gerqf!
Base.LinAlg.LAPACK.geqrt!
Base.LinAlg.LAPACK.geqrt3!
Base.LinAlg.LAPACK.getrf!
Base.LinAlg.LAPACK.tzrzf!
Base.LinAlg.LAPACK.ormrz!
Base.LinAlg.LAPACK.gels!
Base.LinAlg.LAPACK.gesv!
Base.LinAlg.LAPACK.getrs!
Base.LinAlg.LAPACK.getri!
Base.LinAlg.LAPACK.gesvx!
Base.LinAlg.LAPACK.gelsd!
Base.LinAlg.LAPACK.gelsy!
Base.LinAlg.LAPACK.gglse!
Base.LinAlg.LAPACK.geev!
Base.LinAlg.LAPACK.gesdd!
Base.LinAlg.LAPACK.gesvd!
Base.LinAlg.LAPACK.ggsvd!
Base.LinAlg.LAPACK.ggsvd3!

\column{.33\textwidth}

Base.LinAlg.LAPACK.geevx!
Base.LinAlg.LAPACK.ggev!
Base.LinAlg.LAPACK.gtsv!
Base.LinAlg.LAPACK.gttrf!
Base.LinAlg.LAPACK.gttrs!
Base.LinAlg.LAPACK.orglq!
Base.LinAlg.LAPACK.orgqr!
Base.LinAlg.LAPACK.orgql!
Base.LinAlg.LAPACK.orgrq!
Base.LinAlg.LAPACK.ormlq!
Base.LinAlg.LAPACK.ormqr!
Base.LinAlg.LAPACK.ormql!
Base.LinAlg.LAPACK.ormrq!
Base.LinAlg.LAPACK.gemqrt!
Base.LinAlg.LAPACK.posv!
Base.LinAlg.LAPACK.potrf!
Base.LinAlg.LAPACK.potri!
Base.LinAlg.LAPACK.potrs!
Base.LinAlg.LAPACK.pstrf!
Base.LinAlg.LAPACK.ptsv!
Base.LinAlg.LAPACK.pttrf!
Base.LinAlg.LAPACK.pttrs!
Base.LinAlg.LAPACK.trtri!
Base.LinAlg.LAPACK.trtrs!
Base.LinAlg.LAPACK.trcon!
Base.LinAlg.LAPACK.trevc!
Base.LinAlg.LAPACK.trrfs!

\column{.33\textwidth}

Base.LinAlg.LAPACK.stev!
Base.LinAlg.LAPACK.stebz!
Base.LinAlg.LAPACK.stegr!
Base.LinAlg.LAPACK.stein!
Base.LinAlg.LAPACK.syconv!
Base.LinAlg.LAPACK.sysv!
Base.LinAlg.LAPACK.sytrf!
Base.LinAlg.LAPACK.sytri!
Base.LinAlg.LAPACK.sytrs!
Base.LinAlg.LAPACK.hesv!
Base.LinAlg.LAPACK.hetrf!
Base.LinAlg.LAPACK.hetri!
Base.LinAlg.LAPACK.hetrs!
Base.LinAlg.LAPACK.syev!
Base.LinAlg.LAPACK.syevr!
Base.LinAlg.LAPACK.sygvd!
Base.LinAlg.LAPACK.bdsqr!
Base.LinAlg.LAPACK.bdsdc!
Base.LinAlg.LAPACK.gecon!
Base.LinAlg.LAPACK.gehrd!
Base.LinAlg.LAPACK.orghr!
Base.LinAlg.LAPACK.gees!
Base.LinAlg.LAPACK.gges!
Base.LinAlg.LAPACK.trexc!
Base.LinAlg.LAPACK.trsen!
Base.LinAlg.LAPACK.tgsen!
Base.LinAlg.LAPACK.trsyl!

\columnsend

