

import scala.util.Random

object GridWorld {
  val epsilon = 0.1
  val alpha = 0.5
  val gamma = 0.9

  def main(args: Array[String]) = {
    val dimensions = (5,5)
    val grid = (generateGridWorld _).tupled(dimensions)
    grid.foreach(row => { row.foreach(print); println; })
    var qFunction = Array.ofDim[Double](dimensions._1, dimensions._2, 4)
    runSimulation(grid, qFunction)

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
  
  private def getDirection(positionAgent: (Int, Int), qFunction : Array[Array[Array[Double]]]) : Int = {
    if (Random.nextDouble > epsilon) {
	  val currentActions = qFunction(positionAgent._1)(positionAgent._2)
	  val maxQ = currentActions.max
	  // print(positionAgent)
	  // currentActions.foreach(print)
	  // readLine
	  currentActions.indexOf(maxQ)
	} else {
	  // println("epsilon")
	  Random.nextInt(4)
	}
  }
  
  private def runSimulation(grid: Array[Array[Char]], qFunction : Array[Array[Array[Double]]]): Array[Array[Array[Double]]] = {
    var positionAgent = (0, 0)
	var lastPositionAgent = positionAgent
    var pathWent : List[(Int, Int)] = Nil
	var changedQFunction = qFunction
    while (grid(positionAgent._1)(positionAgent._2) != 'G') {
	  val direction = getDirection(positionAgent, qFunction)
	  // println(direction)
	  val possibleNewPositionAgent : (Int, Int) = 
      direction match {
        case 0 => { // nach links
          (positionAgent._1, positionAgent._2 - 1)
        }
        case 1 => { // nach rechts
          (positionAgent._1, positionAgent._2 + 1)
        }
        case 2 => { // nach unten
          (positionAgent._1 + 1, positionAgent._2)
        }
        case 3 => { // nach oben
          (positionAgent._1 - 1, positionAgent._2)
        }
        case _ => {
          println("BAD!")
		  (-1, -1)
        }
      }
      val (nextPositionAgent, reward) = evaluateAction(positionAgent, grid, qFunction, direction, possibleNewPositionAgent)
	  var changedQFunction = qFunction
	  val nextDirection = getDirection(nextPositionAgent, qFunction)
	  changedQFunction(positionAgent._1)(positionAgent._2)(direction) = qFunction(positionAgent._1)(positionAgent._2)(direction) + alpha*(reward + gamma*qFunction(nextPositionAgent._1)(nextPositionAgent._2)(nextDirection) + qFunction(positionAgent._1)(positionAgent._2)(direction))
	  positionAgent = nextPositionAgent
    }
	changedQFunction
  }
  
  def evaluateAction(positionAgent : (Int, Int), grid : Array[Array[Char]], qFunction : Array[Array[Array[Double]]], direction : Int, newPositionAgent : (Int, Int)) : ((Int, Int), Double) = {
     if ((0 until grid.length).contains(newPositionAgent._1) && (0 until grid(0).length).contains(newPositionAgent._2) && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
       //pathWent = positionAgent :: pathWent
	   val reward : Int = if (grid(newPositionAgent._1)(newPositionAgent._2) == 'G') 100 else -1;
       (newPositionAgent, reward)
     } else {
	   (positionAgent, -1)
	 }
  }
}
