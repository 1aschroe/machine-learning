object GridWorld {

  def main(args: Array[String]) = {
    var grid = generateGridWorld(5,5)
    grid.foreach((row: Array[Int]) => { row.foreach((element: Int ) => print(element)); println; })
  }

  def generateGridWorld(xSize: Int, ySize: Int): Array[Array[Int]] = {
    Array.ofDim[Int](xSize,ySize)
  }
}
