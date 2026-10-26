import ../../Input

Day01 :: [].{
	solve : Str -> { part1 : Str, part2 : Str }
	solve = |input| {
		numbers = Input.split_on_lines(input) |> List.map_try(U64.from_str)
		nums = match numbers {
			Ok(parsed_nums) => parsed_nums
			Err(BadNumStr) => return {
				part1: "error parsing input",
				part2: "error parsing input",
			}
		}

		{
			part1: part1(nums) ?? "no matching pair found",
			part2: part2(nums) ?? "no matching triplet found",
		}
	}
}

part1 : List(U64) -> Try(Str, [NotFound])
part1 = |nums| {
	pair = two_sum(nums, 2020.U64)?
	Ok((pair.0 * pair.1).to_str())
}

two_sum : List(U64), U64 -> Try((U64, U64), [NotFound])
two_sum = |nums, target| {

	var $seen = Set.empty()

	for num in nums {
		if num <= target {
			complement = target - num

			if $seen.contains(complement) {
				return Ok((num, complement))
			}
		}

		$seen = $seen.insert(num)
	}

	Err(NotFound)
}

three_sum : List(U64), U64 -> Try((U64, U64, U64), [NotFound])
three_sum = |nums, target| {
	match nums {
		[] => Err(NotFound)
		[first, .. as rest] => {
			if first <= target {
				match two_sum(rest, target - first) {
					Ok(pair) => Ok((first, pair.0, pair.1))
					Err(NotFound) => three_sum(rest, target)
				}
			} else {
				three_sum(rest, target)
			}
		}
	}
}

part2 : List(U64) -> Try(Str, [NotFound])
part2 = |nums| {
	triplet = three_sum(nums, 2020.U64)?

	Ok((triplet.0 * triplet.1 * triplet.2).to_str())
}

sample_numbers = [1721, 979, 366, 299, 675, 1456]

## Finds the two entries from the puzzle sample.
expect two_sum(sample_numbers, 2020) == Ok((299, 1721))

## Does not reuse a single entry to form a pair.
expect two_sum([1010], 2020) == Err(NotFound)

## Finds the three entries from the puzzle sample.
expect three_sum(sample_numbers, 2020) == Ok((979, 675, 366))

## Reports when no three entries add up to the target.
expect three_sum([1, 2, 3], 2020) == Err(NotFound)

## Produces both answers for the puzzle sample.
expect {
	input = "1721\n979\n366\n299\n675\n1456\n"
	Day01.solve(input) == { part1: "514579", part2: "241861950" }
}
