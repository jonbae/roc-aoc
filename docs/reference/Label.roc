Label :: [].{
	decorate : Str -> Str
	decorate = |text| "[${text}]"
}

expect Label.decorate("note") == "[note]"
