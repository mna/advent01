requiredFuel(mass int) int {
  fuel := mass / 3 - 2
  return fuel
}

test() {
  Stdout.writeLine(">>> TEST")
  Stdout.writeLine(format("* 12 want 2 => {}", requiredFuel(12)))
  Stdout.writeLine(format("* 14 want 2 => {}", requiredFuel(14)))
  Stdout.writeLine(format("* 654 want 216 => {}", requiredFuel(654)))
  Stdout.writeLine(format("* 1969 want 654 => {}", requiredFuel(1969)))
  Stdout.writeLine(format("* 100756 want 33583 => {}", requiredFuel(100756)))
  Stdout.writeLine("<<< TEST")
}

main() {
  ::currentAllocator = Memory.heapAllocator()

  test()

  sb := StringBuilder{}
  File.tryReadToStringBuilder("./input.txt", ref sb)

  lines := sb.toString().split('\n')
  count := 0
  total := 0
  for line in lines {
    mass := int.tryParse(line)
    if mass.hasValue {
      //Stdout.writeLine(format(">> {}", mass.unwrap()))
      massNum := mass.unwrap()
      fuel := requiredFuel(massNum)
      //Stdout.writeLine(format(">> {} => {}", massNum, fuel))
      count += 1
      total += fuel

      while true {
        fuel = requiredFuel(fuel)
        if fuel <= 0 {
          break
        }
        total += fuel
      }
    }
  }
  Stdout.writeLine(format("number of masses: {}", count))
  Stdout.writeLine(format("fuel total: {}", total))
}
