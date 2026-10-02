import ../../Input

Day02 :: [].{
	solve : Str -> { part1 : Str, part2 : Str }
	solve = |input| {
		lines = Input.trimmed_lines(input)

		solution1 = part1(lines).to_str()
		solution2 = part2(lines).to_str()

		{
			part1: solution1,
			part2: solution2,
		}
	}
}

part1 : List(Str) -> U64
part1 = |lines| {
	lines.count_if(
		|line| {
			match parse_day02_input(line) {
				Ok(entry) => {
					is_valid_part1(entry)
				}
				Err(_) => crash "invalid entry for day 02"
			}
		},
	)
}

is_valid_part1 : (U64, U64, Str, Str) -> Bool
is_valid_part1 = |(lo, hi, char, password)| {
	char_count : U64
	char_count = password.split_on(char).len() - 1
	lo <= char_count and char_count <= hi
}

is_valid_part2 : (U64, U64, Str, Str) -> Bool
is_valid_part2 = |(pos1, pos2, char, password)| {
	match Str.to_utf8(char) {
		[policy_byte] => {
			password_bytes = Str.to_utf8(password)
			matches_at = |position| {
				if position == 0 {
					False
				} else {
					match List.get(password_bytes, position - 1) {
						Ok(password_byte) => password_byte == policy_byte
						Err(OutOfBounds) => False
					}
				}
			}

			match1 = matches_at(pos1)
			match2 = matches_at(pos2)

			match1 != match2
		}
		_ => False
	}
}

parse_day02_input : Str -> Try((U64, U64, Str, Str), [BadNumStr, InvalidRangeFormat, InvalidCharacterFormat, InvalidPasswordEntry])
parse_day02_input = |line| {
	match line.split_on(" ") {
		[range, char_str, password] => {
			match range.split_on("-") {
				[low_str, high_str] => {
					low = U64.from_str(low_str)?
					high = U64.from_str(high_str)?
					match char_str.split_on(":") {
						[char, _] => {
							Ok((low, high, char, password))
						}
						_ => Err(InvalidCharacterFormat)
					}
				}
				_ => Err(InvalidRangeFormat)
			}

		}
		_ => Err(InvalidPasswordEntry)
	}

}

part2 : List(Str) -> U64
part2 = |lines| {
	lines.count_if(
		|line| {
			match parse_day02_input(line) {
				Ok(entry) => {
					is_valid_part2(entry)
				}
				Err(_) => crash "invalid entry for day 02"
			}
		},
	)
}

sample_lines = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

## Parses a password-policy entry into its four fields.
expect parse_day02_input("1-3 a: abcde") == Ok((1, 3, "a", "abcde"))

## Rejects an entry whose range is malformed.
expect parse_day02_input("1/3 a: abcde") == Err(InvalidRangeFormat)

## Treats both count limits as inclusive for part 1.
expect {
	is_valid_part1((1, 3, "a", "abcde"))
		and is_valid_part1((1, 3, "a", "aaabc"))
			and !is_valid_part1((1, 3, "b", "cdefg"))
}

## Requires the policy character at exactly one position for part 2.
expect {
	is_valid_part2((1, 3, "a", "abcde"))
		and !is_valid_part2((1, 3, "b", "cdefg"))
			and !is_valid_part2((2, 9, "c", "ccccccccc"))
}

## Counts valid passwords from the puzzle sample.
expect part1(sample_lines) == 2
expect part2(sample_lines) == 1

## Produces both answers for the puzzle sample.
expect {
	input = "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc\n"
	Day02.solve(input) == { part1: "2", part2: "1" }
}
