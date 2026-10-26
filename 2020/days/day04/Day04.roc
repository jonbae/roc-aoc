import ../../Input

Day04 :: [].{
    solve : Str -> { part1 : Str, part2 : Str }
    solve = |input| {
        segments = Input.split_on_blank_lines(input.replace_each("\r\n", "\n"))
        passports = match parse_segments_to_dict(segments) {
            Ok(parsed_passports) => parsed_passports
            Err(_) => return {
                part1: "error parsing input",
                part2: "error parsing input"
            }
        }

        valid_passports_count = count_valid_passports(passports)


        {
            part1: valid_passports_count.to_str(), # valid_passports_count.to_str(),
            part2: "not implemented" # valid_passports_strict_count.to_str()
        }
    }


}

ParseError : [
    InvalidUtf8Segment(List(U8)),
    InvalidSegment(List(U8)),
]
parse_segments_to_dict : List(Str) -> Try(List(Dict(Str, Str)), ParseError)
parse_segments_to_dict = |segments| {
    segments.map_try(|segment| {
        $passport : Dict(Str, Str)
        var $passport = Dict.empty()
        
        var $left = 0
        var $right = 0
        char_bytes : List(U8)
        char_bytes = segment.to_utf8()
        while $right < char_bytes.len() {
            byte = char_bytes.get($right)?? 0
            if byte == 32 or byte == 10 { # space or newline
                field_bytes = char_bytes.sublist({start: $left, len: $right - $left})
                $passport = insert_field(field_bytes, $passport)?
                $left = $right + 1
                $right = $left
            }
            $right = $right + 1
        }

        final_field_bytes = char_bytes.sublist({start: $left, len: $right - $left})
        $passport = insert_field(final_field_bytes, $passport)?
        Ok($passport)
    })
}

insert_field : List(U8), Dict(Str, Str) -> Try(Dict(Str, Str), ParseError)
insert_field = |field_bytes, passport| {
    match field_bytes.split_on(58) { # ':'
        [key, value] => {
            match (Str.from_utf8(key), Str.from_utf8(value)) {
                (Ok(key_str), Ok(value_str)) => Ok(Dict.insert(passport, key_str, value_str))
                _ => Err(InvalidUtf8Segment(field_bytes))
            }
        }
        _ => Err(InvalidSegment(field_bytes))
    }
}


Passport : {
    ecl: Str 
    pid: U64 
    eyr: U64 
    hcl: Str
    byr: U64 
    iyr: U64 
    hgt: Str
    cid?: U64 
}
count_valid_passports : List(Dict(Str, Str)) -> U64
count_valid_passports = |passports| {
    passports.fold(0, |count, passport| {
        match (
            Dict.get(passport, "ecl"),
            Dict.get(passport, "pid"),
            Dict.get(passport, "eyr"),
            Dict.get(passport, "hcl"),
            Dict.get(passport, "byr"),
            Dict.get(passport, "iyr"),
            Dict.get(passport, "hgt"),
        ) {
            (Ok(_), Ok(_), Ok(_), Ok(_), Ok(_), Ok(_), Ok(_)) => count + 1
            _ => count
        }
    })

}
sample_passports : List(Dict(Str, Str))
sample_passports = [
    Dict.empty()
        .insert("ecl", "gry")
        .insert("pid", "860033327")
        .insert("eyr", "2020")
        .insert("hcl", "#fffffd")
        .insert("byr", "1937")
        .insert("iyr", "2017")
        .insert("cid", "147")
        .insert("hgt", "183cm"),

    Dict.empty()
        .insert("iyr", "2013")
        .insert("ecl", "amb")
        .insert("cid", "350")
        .insert("eyr", "2023")
        .insert("pid", "028048884")
        .insert("hcl", "#cfa07d")
        .insert("byr", "1929"),

    Dict.empty()
        .insert("hcl", "#ae17e1")
        .insert("iyr", "2013")
        .insert("eyr", "2024")
        .insert("ecl", "brn")
        .insert("pid", "760753108")
        .insert("byr", "1931")
        .insert("hgt", "179cm"),

    Dict.empty()
        .insert("hcl", "#cfa07d")
        .insert("eyr", "2025")
        .insert("pid", "166559648")
        .insert("iyr", "2011")
        .insert("ecl", "brn")
        .insert("hgt", "59in"),
]

expect {
    actual = count_valid_passports(sample_passports)
    dbg actual
    actual == 2
}


expect {
    actual = parse_segments_to_dict(["a:one b:two"])
    dbg actual
    actual == Ok([
        Dict.empty().insert("a", "one").insert("b", "two"),
    ])
}
