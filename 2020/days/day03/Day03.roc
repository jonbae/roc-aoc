import ../../Input

Day03 :: [].{
  solve : Str -> { part1 : Str, part2 : Str }
  solve = |input| {
    lines = Input.trimmed_lines(input)
    tree_count = count_trees(lines).to_str()
    
    {
      part1: tree_count,
      part2: "solution2"
    }
  }
}

count_trees : List(Str) -> U64
count_trees = |rows| {
  match rows {
    [] => 0
    [_starting_row, .. as remaining_rows] => {
      var $x = 3 
      var $tree_count = 0

      for row in remaining_rows {
        if is_at_tree(row, $x) {
          $tree_count = $tree_count + 1
        }
        $x = $x + 3
      }
      $tree_count
    }
  }
}


is_at_tree : Str, U64 -> Bool
is_at_tree = |line, x| {
  row_bytes = line.to_utf8() 
  width = row_bytes.len()
  wrapped_x = x % width

  match row_bytes.get(wrapped_x) {
    Ok(byte) => byte == 35 # byte value of '#'
    Err(OutOfBounds) => False
  }
}