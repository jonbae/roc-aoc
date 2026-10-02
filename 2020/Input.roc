Input :: [].{
	# Preserve blank lines; some AoC puzzles use them as separators.
	lines : Str -> List(Str)
	lines = |text| Str.split_on(text, "\n")

	# Useful for the common case where a trailing newline should be ignored.
	trimmed_lines : Str -> List(Str)
	trimmed_lines = |text| {
		trimmed = Str.trim(text)

		if Str.is_empty(trimmed) {
			[]
		} else {
			Str.split_on(trimmed, "\n")
		}
	}

	# Split an input containing blank-line-separated groups.
	sections : Str -> List(Str)
	sections = |text| Str.split_on(Str.trim(text), "\n\n")

	# Split a line on spaces. Puzzle-specific validation belongs in the day module.
	fields : Str -> List(Str)
	fields = |line| Str.split_on(line, " ")
}
