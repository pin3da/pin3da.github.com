---
title: "Advent of Kotlin"
date: 2020-12-22T15:20:52+01:00
draft: false
toc: false
images:
tags: 
  - kotlin
  - programming
---

Since [2018](https://github.com/pin3da/advent-of-code/tree/master/2018) I started participating in [Advent of Code](https://adventofcode.com/) with the goal of learning new programming languages. This year I choosed [kotlin](https://kotlinlang.org/), and the experience was very good. I'll list some of the language features I liked so far.

## Sealed Classes

For [Day's 14](https://adventofcode.com/2020/day/14) solution I wanted to have a class `Entry` and different subclasses of it. The only difference with normal [OOP inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)) is that I wanted to restric all the object to belong exactly to a single subclass. It turns out that sealed classes are designed for this behavior.

{{< highlight kotlin >}}
sealed class Entry
data class Mask(val mask: CharArray) : Entry()
data class Mem(val addr: Long, val value: Long) : Entry()
{{< /highlight >}}

## When statement

Now, in order to evaluate the different kinds of `Entry` we need to conditionally check its "real" type. This is a good use case for the `when` statement:

{{< highlight kotlin >}}
when (entry) {
  is Mask -> mask = entry.mask
  is Mem -> memory[entry.addr] = applyMask(entry.value, mask)
}
{{< /highlight >}}

Since the class was sealed, the compiler *knows* all the possible subclasses and will verify that there is a proper evaluation for all of them. For instance, if we add a new subclass of `Entry` we will get an error in the code above (which would be uncaught otherwise).

Another nice property of the `when` statement is that we can use it for conditional branching executions (an statement), but also as an expression.


- Conditional execution, this is very similar to `switch` in other programming languages (nothing surprising here):
{{< highlight kotlin >}}
val a = 10
when (a) {
    3 -> println("first condition")
    4 -> println("second condition")
    else -> println("else")
}
{{< /highlight >}}
- Statement: This allows to reduce unnecessary mutability in the message, unlike the `if` alternative:
{{< highlight kotlin >}}
// Immutable (defined as val)
val msg = when(a) {
    3 -> "first condition"
    4 -> "second condition"
    else -> "else"
}
// Mutable (defined as var)
var msg = "else"
if (a == 3) {
    msg = "first condition" 
} else if (a == 4) {
    msg = "second condition"
}
{{< /highlight >}}

Note: Initially I thouhgt that having `val` and `var` was very confusing, but in practice I found it handy and easy to remember  ¯\\_(ツ)_/¯

## Functional flavor

After a few solutions I got used to the functional-like approach that kotlin uses, the support for lambda functions is really good and the code ends being clear and concise. This will also help to reduce mutablility in some places.

Example, let's parse the input for day 1's challenge, and get its sum.

{{< highlight kotlin >}}
// Both variables can be immutable.
val numbers = File("data/01.in").readLines().map { it.toInt() }
val sum = numbers.sum()
// Do something else with numbers
{{< /highlight >}}

{{< highlight kotlin >}}
// Both variables must be mutable.
var numbers = mutableListOf()
for (line in File("data/01.in").readLines()) {
    numbers.add(line.toInt())
}
var sum = 0
for (n in numbers) {
    sum += n
}
// Do something else with numbers
{{< /highlight >}}


## Data Classes

In most of the challenges I ended creating classes that only hold information, and use those classes in maps or sets (which require some sort of comparator or hash). I also often want to print these objects.

In C++ I would end doing something like:

{{< highlight cc >}}
struct Entry {
    int add;
    long value;
    bool operator < (const Entry& other) const {
        if (add != other.add) return add < other.add;
        return value < other.value;
    }
}

ostream& operator<<(ostream& os, const Entry& entry) {
    os << '{' << entry.add << ": " << entry.value << '}';
    return os;
}
{{< /highlight >}}

But in kotlin, it is a one-liner :D.

{{< highlight kotlin >}}
data class Entry(val add: Int, val value: Long)
{{< /highlight >}}
