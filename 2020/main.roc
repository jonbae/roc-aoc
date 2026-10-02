app [main!] {
	cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.22.2/9zUBxb1LtXYVc4eR4hAtd1WQDwBYDhM6HQdZz1UFCm2m.tar.zst",
	roc: "nightly-2026-09-18-1d982dc",
}

import cli.Path
import cli.Stderr
import cli.Stdout
import days/day01/Day01
import days/day02/Day02
import days/day03/Day03
run_day! = |input_path, solve| {
	input = Path.read_utf8!(input_path)?
	answers = solve(input)

	Stdout.line!("Part 1: ${answers.part1}")?
	Stdout.line!("Part 2: ${answers.part2}")
}

run! = |args| {
	day_arg = List.get(args, 1) ? |_| MissingDay
	day = Path.from_os_str(day_arg) |> Path.display

	match day {
		"01" => run_day!("days/day01/input.txt", Day01.solve)
		"02" => run_day!("days/day02/input.txt", Day02.solve)
		"03" => run_day!("days/day03/input.txt", Day03.solve)
		_ => Err(UnknownDay(day))
	}
}

main! = |args| {
	match run!(args) {
		Ok({}) => Ok({})
		Err(MissingDay) => {
			_ = Stderr.line!("Usage: roc main.roc -- DAY\nExample: roc main.roc -- 01")
			Err(Exit(1))
		}
		Err(UnknownDay(day)) => {
			_ = Stderr.line!("No solution is registered for day ${day}.")
			Err(Exit(1))
		}
		Err(err) => Err(err)
	}
}
