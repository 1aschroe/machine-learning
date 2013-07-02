

import scala.util.Random

object GridWorld {

  def main(args: Array[String]) = {
    val dimensions = (5,5)
    val grid = (generateGridWorld _).tupled(dimensions)
//    grid.foreach((row: Array[Char]) => { row.foreach((element: Char) => print(element)); println; })
    var valueFunction = Array.ofDim[Double](dimensions._1, dimensions._2)
    runSimulation(grid)

    println("DONE!")
  }

  def generateGridWorld(xSize: Int, ySize: Int): Array[Array[Char]] = {
    var result = Array.fill[Char](xSize, ySize)(' ')

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
  
  private def runSimulation(grid: Array[Array[Char]]): Unit = {
    var positionAgent = (0, 0)
    var pathWent : List[(Int, Int)] = Nil
    while (grid(positionAgent._1)(positionAgent._2) != 'G') {
      val direction = Random.nextInt(4)
      direction match {
        case 0 => { // nach links
          val newPositionAgent = (positionAgent._1, positionAgent._2 - 1)
          if (newPositionAgent._2 >= 0 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            pathWent = positionAgent :: pathWent
            positionAgent = newPositionAgent
          }
        }
        case 1 => { // nach rechts
          val newPositionAgent = (positionAgent._1, positionAgent._2 + 1)
          if (newPositionAgent._2 <= grid(0).length - 1 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            pathWent = positionAgent :: pathWent
            positionAgent = newPositionAgent
          }
        }
        case 2 => { // nach unten
          val newPositionAgent = (positionAgent._1 + 1, positionAgent._2)
          if (newPositionAgent._1 <= grid.length - 1 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            pathWent = positionAgent :: pathWent
            positionAgent = newPositionAgent
          }
        }
        case 3 => { // nach oben
          val newPositionAgent = (positionAgent._1 - 1, positionAgent._2)
          if (newPositionAgent._1 > 0 && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
            pathWent = positionAgent :: pathWent
            positionAgent = newPositionAgent
          }
        }
        case _ => {
          println("BAD!")
        }
      }
    }
  }
}
