import scala.util.Random

object GridWorld {

  def main(args: Array[String]) = {
    var grid = generateGridWorld(5,5)
    grid.foreach((row: Array[Char]) => { row.foreach((element: Char ) => print(element)); println; })
    var positionAgent = (0, 0)
    println(positionAgent)
    while(grid(positionAgent._1)(positionAgent._2) != 'G') {
      val direction = Random.nextInt(3)
      direction match {
        case 0 => { // nach oben
          val newPositionAgent = (positionAgent._1, positionAgent._2 -  1)
          if (newPositionAgent._2 >= 0 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            positionAgent = newPositionAgent
          }
        }
        case 1 => { // nach unten
          val newPositionAgent = (positionAgent._1, positionAgent._2 +  1)
          if (newPositionAgent._2 < grid(0).length - 1 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            positionAgent = newPositionAgent
          }
        }
        case _ => {}
      }
    }
  }

  def generateGridWorld(xSize: Int, ySize: Int): Array[Array[Char]] = {
    var result = Array.fill[Char](xSize,ySize)(' ')
    
    result(1)(1) = 'X'
    result(1)(2) = 'X'
    result(1)(3) = 'X'
    result(3)(2) = 'X'
    result(4)(2) = 'X'
    result(1)(2) = 'X'
    
    result(0)(0) = 'S'
    result(4)(4) = 'G'
    
    result
  }
}
