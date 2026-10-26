import ../../Input

Day03 :: [].{
  solve : Str -> { part1 : Str, part2 : Str }
  solve = |input| {
    lines = Input.split_on_lines(input)
    tree_count = count_trees(lines, 3, 1)
    
    tree_count_2 = count_trees(lines, 1, 1)
    tree_count_3 = count_trees(lines, 5, 1)
    tree_count_4 = count_trees(lines, 7, 1)
    tree_count_5 = count_trees(lines, 1, 2)
    tree_count_product = tree_count * tree_count_2 * tree_count_3 * tree_count_4 * tree_count_5

    {
      part1: tree_count.to_str(),
      part2: tree_count_product.to_str()
    }
  }
}

count_trees : List(Str), U64, U64 -> U64
count_trees = |rows, right, down| {
  match rows {
    [] => 0
    [_starting_row, .. as remaining_rows] => {
      var $x = right
      var $tree_count = 0
      var $row_index = 1
      
      
      for row in remaining_rows {
        if $row_index % down == 0 {
          if is_at_tree(row, $x) {
            $tree_count = $tree_count + 1
          }
          $x = $x + right
        }
        $row_index = $row_index + 1
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