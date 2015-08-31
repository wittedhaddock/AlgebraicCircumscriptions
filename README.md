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

##### Computations

The magnitude (distance) of a vector can be accessed by `magnitude` of ACVector


