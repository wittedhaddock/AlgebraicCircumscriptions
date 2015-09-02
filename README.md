# Circumscriptions in Algebra
Algebra &amp; Friends in Swift. This library implements algebra from scratch. As development continues, phenomena from Matrix, Probability, and Measure theories will emerge. And from that, ideas of higher abstractions (statistical analysis and machine learning, most notably) will form.

The goals of this library will be derived from the following three themes: speed, reliability, and modularity. It is very important that complexity is meaningfully separated so that additions can be made from the "right" amount of pre-existing parts.
Furthermore, it is crucial that documentation exists such to allow an unlearned developer, with as little friction as possible, quick and exhaustive acclimation.

## The Core Couple

The Vector class, ACVector, is a fundamental of this library, as near-everything else is built from using it. The second fundamental class, ACMatrix, uses ACVector in its own implementation.
It is these two classes that comprise the core of this computationally expressed algebra. 
(It is important to note that both ACMatrix and ACVector conform to the fundamental protocol, Euclidean, which will be illustrated more later)

Each element within a vector, and transitively in a Matrix, is currently hard-typed as a Double (a special struct in Swift).

### Vector Basics

##### Instantiation
Instantiating a vector is easy, and can be done by either using specific entries, or by providing a dimension.

For example, to create a 4 dimensional vector with specific entries:

```swift 
let myVec = ACVector([1, 2, 3, 4]) 
```

Or to create a zero vector in the 4th dimension,
```swift
let myZeroVec = ACVector(4)
```

To access dimension of a vector directly, you may

```swift
let dimension = myVec.dimension
println(dimension)
4
```

##### Indexing & Printing
Vector elements can be accessed by using familiar array-like indexing.
From the examples above,

```swift
println("the third element of my first vector is: \(myVec[2]), and the second element of my second vector is \(myZeroVec[1])")
```
results by printing the following
```
the third element of my first vector is: 3, and the second element of my second vector is 0
```
And since ACVector conforms to Printable, you can pass an entire vector for printing.

```println(myVec) ``` prints ``` [1, 2, 3, 4] ```

##### Magnitudes & Normalizations

The magnitude (distance) of a vector can be accessed by `magnitude` of ACVector

```swift
let vec = ACVector([3.0, 4.0])
println(vec.magnitude)
5.0

let vec2 = ACVector([3.0, 4.0, 5.0])
println(vec2.magnitude)
7.07106781186548

```

The magnitude can also be set

```swift
let vec = ACVector([3.0, 4.0])
vec.magnitude = 10
println(vec)
[6.0, 8.0]

let vec2 = ACVector([3.0, 4.0, 5.0])
vec2.magnitude = 1 // unit vector
println(vec2)
[0.424264068711929, 0.565685424949238, 0.707106781186547]

```

Unit vectors, vectors whose magnitudes are 1, can yield from calling `normalize()` on any vector
```swift
let vec = ACVector([3.0, 4.0])
vec.normalize()
println(vec)
[0.6, 0.8]

let vec2 = ACVector([3.0, 4.0, 5.0])
vec2.normalize()
println(vec2)
[0.424264068711929, 0.565685424949238, 0.707106781186547] // same result as when mag was manually set to 1
```

#### Vector Operators

Many regular arithmetic and geometric operators have been overloaded to support Vector operations. 

Some examples:

###### Vector-Vector Addition

```Swift
var vec1: ACVector = ACVector([1, 2, 3, 4, 5])
var vec2 : ACVector = ACVector([1, 2, 3, 4, 5])
println(vec1 + vec2)
[2.0, 4.0, 6.0, 8.0, 10.0]
```

###### Vector-Vector Multiplication
```Swift
var vec1: ACVector = ACVector([30, 20, 10]);
var vec2: ACVector = ACVector([15, 30, 45]);
println(vec1 * vec2)
1500.0
```

###### Equality
```Swift 
var vec1: ACVector = ACVector([30, 20, 10]);
var vec2: ACVector = ACVector([15, 30, 45]);
println(vec1 == vec2)
false

println(vec1 != vec2)
true
```

These are some of the possible vector computations. There also exists vector-scalar mutliplication and division, and vector-vector substraction. 

### Matrix Basics

The matrix functions analogously to the Vector. 

Matrices can be instantiated by supplying a tuple containing number of rows columns, an array of PVectors, and arrays of arrays of elements (of type Double).

```swift
let matrix1 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
println(matrix1)
[1.0, 2.0, 3.0]
[2.0, 3.0, 4.0]
[5.0, 6.0, 7.0]

let matrix2 = ACMatrix((4, 9))
println(matrix2)
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
```

ACMatrix instances can be indexed through subscripting

```swift
let matrix1 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
let middleRowVector = matrix1[1] //ACVector([2, 3, 4])
println(middleRowVector)
[2.0, 3.0, 4.0]

let middleValue = matrix[1][1]
println(middleValue)
3.0
```

Matrices can be transposed (element at position i,j becomes element at position j, i)

```swift
let matrix1 = ACMatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
println(matrix1)
[1.0, 2.0, 3.0]
[4.0, 5.0, 6.0]
[7.0, 8.0, 9.0]

matrix1.transpose()
println(matrix1)
[1.0, 4.0, 7.0]
[2.0, 5.0, 8.0]
[3.0, 6.0, 9.0]
```

#### Matrix Operators

Similar to ACVector, ACMatrix overloads the standard math/logic operators.

###### Matrix-Matrix Addition

```swift 
let matrix1 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
let matrix2 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
println(matrix1 + matrix2)
[2.0, 4.0, 6.0]
[4.0, 6.0, 8.0]
[10.0, 12.0, 14.0]
```

###### Matrix-Vector & Vector-Matrix Multiplication (col by row & row by col) (not communicative) 
For col * row, number of entries in column (# rows) must equal number of entries in row (# cols) 
For row * col, number of entries in row (# cols) must equal number of entries in col (# rows), and they should both be 1
```swift
var matrix = ACMatrix([[2], [-1], [5]])
var vector = ACVector([5, 1, 5])

println(matrix * vector)
[10.0, 2.0, 10.0]
[-5.0, -1.0, -5.0]
[25.0, 5.0, 25.0]

println(vector * matrix)
[34.0]
```
###### Matrix-Matrix Multiplication (not communicative)

Like Matrix-Vector multiplication, the matrix on the left must have the same number of columns as the multiplying matrix on the right has rows.

```swift
var mat = ACMatrix([[1, 2, 3], [2, 3, 4]])
var mat2 = ACMatrix([[1, 2], [2, 3], [3, 4]])

println(mat * mat2)
[14.0, 20.0]
[20.0, 29.0]

println(mat2 * mat)

[5.0, 8.0, 11.0]
[8.0, 13.0, 18.0]
[11.0, 18.0, 25.0]

```

#### Matrix dimension, echelon form, and Gaussian elimination

The dimension of a matrix involves more considerations than that of a vector. The dimension of the matrix is the number of "pivot" columns remaining after a matrix receives gaussian elimination (or rank). When the "pivots" are "visible" in the matrix, the flag `echelonForm` of ACMatrix evaluates to true. 

To perform elimination on a matrix (putting it into echelon form),  invoke `eliminate()`

```swift
let matrix = ACMatrix([[40, 50, 60, -200, 101],
                       [39, 50, 60, -200, 101],
                       [1, 3, 9, 10, 11],
                       [90, 10, -30, 33, 34],
                       [100, 1, -9, 3, 4]])
        
println(matrix)
[40.0, 50.0, 60.0, -200.0, 101.0]
[39.0, 50.0, 60.0, -200.0, 101.0]
[1.0, 3.0, 9.0, 10.0, 11.0]
[90.0, 10.0, -30.0, 33.0, 34.0]
[100.0, 1.0, -9.0, 3.0, 4.0]

matrix.eliminate()

println(matrix)
[40.0, 50.0, 60.0, -200.0, 101.0]
[0.0, 1.25, 1.5, -5.0, 2.525]
[0.0, 0.0, 5.4, 22.0, 4.94]
[0.0, 0.0, 0.0, 244.111111111111, 52.2222222222226]
[0.0, 0.0, 0.0, 0.0, 0.92371415566728]
```
As we can see, all has been eliminated below the diagonal, and the rank of this matrix is 5.
It looks like it's in echelon form, too. 

```swift
println(matrix.echelonForm)
true
```

