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
