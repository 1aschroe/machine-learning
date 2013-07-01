package hello

object GridWorld {

  def main(args: Array[String]) = {
    var grid = generateGridWorld(5,5)
    grid.foreach((row: Array[Int]) => { row.foreach((element: Int ) => print("\t" + element)); println; })
  }

  def generateGridWorld(xSize: Int, ySize: Int): Array[Array[Int]] = {
    var result = Array.ofDim[Int](xSize,ySize)
    
    result(1)(1) = -1
    result(1)(2) = -1
    result(1)(3) = -1
    result(3)(2) = -1
    result(4)(2) = -1
    result(1)(2) = -1
    
    result(0)(0) = 1
    result(4)(4) = 2
    
    result
  }
}
