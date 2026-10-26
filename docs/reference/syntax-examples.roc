# Companion to ../roc-syntax-guide.md. No Advent of Code puzzle logic.
# From the repository root: roc test docs/reference/syntax-examples.roc
# Verified with nightly-2026-09-18-1d982dc.

app [main!] { roc: "nightly-2026-09-18-1d982dc" }

import Label

main! = |_| Ok({})

log! : Str => {}
log! = |text| echo!(text)

debug_double : I64 -> I64
debug_double = |number| {
	dbg number
	double(number)
}

## Functions and blocks
add : I64, I64 -> I64
add = |left, right| left + right

double : I64 -> I64
double = |number| {
	result = number * 2
	result
}

identity : a -> a
identity = |value| value

make_label : Str, U64 -> Str
make_label = |name, count| "${name}: ${count.to_str()}"

greeting = || "Hello"

expect add(3, 4) == 7
expect double(6) == 12
expect identity("note") == "note"
expect make_label("items", 3) == "items: 3"
expect greeting() == "Hello"
expect Label.decorate("note") == "[note]"

expect {
	base = 5
	computed = {
		next = base + 2
		next * 3
	}
	computed == 21
}

## Literals and operators
expect 1_000 == 1000
expect 0x10 == 16
expect 0b101 == 5
expect 0o10 == 8
expect 0.1 + 0.2 == 0.3
expect 7.I64 // 2 == 3
expect 7.I64 % 2 == 1
expect 7.Dec / 2 == 3.5
expect -3.I64 < 0
expect 2 <= 2 and 3 >= 2
expect 2 != 3 and !(2 > 3)
expect Bool.True or Bool.False

## Conditionals and patterns
describe_sign : I64 -> Str
describe_sign = |number| {
	if number < 0 {
		"negative"
	} else if number == 0 {
		"zero"
	} else {
		"positive"
	}
}

head_or_zero : List(I64) -> I64
head_or_zero = |numbers| match numbers {
	[] => 0
	[head, ..] => head
}

tail_or_empty : List(I64) -> List(I64)
tail_or_empty = |numbers| match numbers {
	[] => []
	[_, .. as tail] => tail
}

size_label : List(I64) -> Str
size_label = |numbers| match numbers {
	[] => "empty"
	[only] if only > 0 => "one positive"
	[_] => "one other"
	[_, _, ..] => "several"
}

light_label : [Red, Yellow, Green] -> Str
light_label = |light| match light {
	Red | Yellow => "wait"
	Green => "go"
}

expect describe_sign(-2) == "negative"
expect describe_sign(0) == "zero"
expect describe_sign(2) == "positive"
expect head_or_zero([]) == 0
expect head_or_zero([7, 8]) == 7
expect tail_or_empty([7, 8, 9]) == [8, 9]
expect size_label([2]) == "one positive"
expect size_label([-2]) == "one other"
expect size_label([2, 3]) == "several"
expect light_label(Yellow) == "wait"

## Records and tuples
Point : { x : I64, y : I64 }

move_right : Point -> Point
move_right = |point| { ..point, x: point.x + 1 }

record_total : Point -> I64
record_total = |point| {
	{ x, y } = point
	x + y
}

expect {
	point : Point
	point = { x: 2, y: 5 }
	moved = move_right(point)
	moved.x == 3 and point.x == 2 and record_total(point) == 7
}

expect {
	name = "pen"
	count = 3
	item = { name, count }
	item.name == "pen" and item.count == 3
}

expect {
	pair : (Str, U64)
	pair = ("pen", 3)
	(name, count) = pair
	pair.0 == name and pair.1 == count
}

## Strings
expect "line\nnext".split_on("\n") == ["line", "next"]
expect "  note  ".trim() == "note"
expect Str.concat("note", "book") == "notebook"
expect Str.join_with(["a", "b"], ",") == "a,b"
expect "abc".contains("b")
expect "".is_empty()
expect "cat".to_utf8() == [99, 97, 116]
expect "é".count_utf8_bytes() == 2
expect "abc".split_on("") == ["abc"]

two_lines : Str
two_lines =
	\\first
	\\second

expect two_lines == "first\nsecond"

## Lists and pipelines
expect [2, 5, 8].len() == 3
expect List.get([2, 5, 8], 1) == Ok(5)
expect List.get([2, 5, 8], 9) == Err(OutOfBounds)
expect List.first([]) == Err(ListWasEmpty)
expect [2, 5, 8].map(|n| n * 2) == [4, 10, 16]
expect [2, 5, 8].keep_if(|n| n > 4) == [5, 8]
expect [2, 5, 8].fold(0, |total, n| total + n) == 15
expect List.map([2, 5, 8], double) == [4, 10, 16]
expect ([2, 5, 8] |> List.map(double)) == [4, 10, 16]
expect ([2, 5, 8] |> List.map(double) |> List.fold(0, |total, n| total + n)) == 30
expect List.map_try(["3", "9"], U64.from_str) == Ok([3, 9])
expect List.map_try(["3", "oops"], U64.from_str) == Err(BadNumStr)

## Tags and Try
Entry : [Word(Str), Count(U64)]

entry_label : Entry -> Str
entry_label = |entry| match entry {
	Word(text) => text
	Count(number) => number.to_str()
}

parse_count : Str -> Try(U64, [BadNumStr])
parse_count = |text| {
	number = U64.from_str(text)?
	Ok(number)
}

parse_count_explicit : Str -> Try(U64, [BadNumStr])
parse_count_explicit = |text| {
	number = match U64.from_str(text) {
		Ok(value) => value
		Err(error) => return Err(error)
	}
	Ok(number)
}

parse_named_count : Str -> Try(U64, [InvalidCount(Str)])
parse_named_count = |text| {
	number = U64.from_str(text) ? |_| InvalidCount(text)
	Ok(number)
}

expect entry_label(Word("pen")) == "pen"
expect entry_label(Count(3)) == "3"
expect parse_count("23") == Ok(23)
expect parse_count("oops") == Err(BadNumStr)
expect parse_count_explicit("23") == parse_count("23")
expect parse_count_explicit("oops") == parse_count("oops")
expect parse_named_count("oops") == Err(InvalidCount("oops"))
expect (U64.from_str("oops") ?? 0) == 0
expect (U64.from_str("23") ?? 0) == 23

## Local variables and iteration
sum_loop : List(I64) -> I64
sum_loop = |numbers| {
	var $total = 0
	for number in numbers {
		$total = $total + number
	}
	$total
}

count_up : U64 -> U64
count_up = |limit| {
	var $count = 0
	while $count < limit {
		$count = $count + 1
	}
	$count
}

contains_zero : List(I64) -> Bool
contains_zero = |numbers| {
	var $found = Bool.False
	for number in numbers {
		if number == 0 {
			$found = Bool.True
			break
		} else {
			{}
		}
	}
	$found
}

sum_recursive : List(I64) -> I64
sum_recursive = |numbers| match numbers {
	[] => 0
	[head, .. as tail] => head + sum_recursive(tail)
}

expect sum_loop([2, 5, 8]) == 15
expect sum_loop([]) == 0
expect count_up(4) == 4
expect contains_zero([2, 0, 8])
expect !contains_zero([2, 5, 8])
expect sum_recursive([2, 5, 8]) == 15

## Dictionaries
expect {
	original : Dict(Str, U64)
	original = Dict.empty().insert("pen", 3)
	updated = original.insert("pen", 4)
	original.get("pen") == Ok(3) and updated.get("pen") == Ok(4)
}

expect {
	counts : Dict(Str, U64)
	counts = Dict.empty().insert("pen", 3)
	counts.get("paper") == Err(KeyNotFound) and counts.len() == 1
}

## Nominal and opaque types
Position := { x : I64, y : I64 }

position_x : Position -> I64
position_x = |Position.{ x, y: _ }| x

Token :: { text : Str }.{
	new : Str -> Token
	new = |text| { text: text }

	read : Token -> Str
	read = |token| token.text
}

expect position_x(Position.{ x: 2, y: 5 }) == 2
expect Token.read(Token.new("note")) == "note"

## Generic method constraints
as_text : a -> Str where [a.to_str : a -> Str]
as_text = |value| value.to_str()

expect as_text(23.U64) == "23"
