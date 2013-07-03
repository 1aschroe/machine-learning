

import scala.util.Random

object GridWorld {
  val verbose = true

  val epsilon = 0.1
  val alpha = 0.7
  val gamma = 0.9

  val dimensions = (5,5)
  val grid = (generateGridWorld _).tupled(dimensions)
  grid.foreach(row => { row.foreach(print); println; })

  def main(args: Array[String]) = {
    var qFunction = Array.ofDim[Double](dimensions._1, dimensions._2, 4)
    for (i <- 1 to 500) {
      qFunction = runSimulation(grid, qFunction)
      if (verbose) {
      println("The value function:")
      for (j <- 0 until dimensions._1) {
        for (k <- 0 until dimensions._2) {
          print("\t%1.0f" format qFunction(j)(k).sum)
        }
        println
      }
      println("The implicit policy:")
      for (j <- 0 until dimensions._1) {
        for (k <- 0 until dimensions._2) {
          print("\t")
          if (grid(j)(k) == 'G' || grid(j)(k) == 'X') {
            print(grid(j)(k))
          } else {
  	    val currentActions = qFunction(j)(k)
	    val maxQ = currentActions.max
	    val indicesWithMaxQ = currentActions.zipWithIndex.filter(_._1==maxQ).map(_._2)
            indicesWithMaxQ.map(directionDescription(_).charAt(0)).foreach(print)
          }
        }
        println
      }
      }
    }

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
  
  private def printSituation(positionAgent : (Int, Int)) {
    val before = grid(positionAgent._1)(positionAgent._2)
	grid(positionAgent._1)(positionAgent._2) = 'o'
	println
    grid.foreach(row => { row.foreach(print); println; })
	grid(positionAgent._1)(positionAgent._2) = before
	readLine
  }
  
  val directionDescription = Map(0 -> "left", 1 -> "right", 2 -> "down", 3 -> "up")
  
  private def getDirection(positionAgent: (Int, Int), qFunction : Array[Array[Array[Double]]]) : Int = {
    if (Random.nextDouble > epsilon) {
      getDeterministicDirection(positionAgent, qFunction)
	} else {
	  if (verbose) println("Chose epsilon-strategy to walk randomly")
	  Random.nextInt(4)
	}
  }
  
  private def getDeterministicDirection(positionAgent: (Int, Int), qFunction : Array[Array[Array[Double]]]) : Int = {
  	val currentActions = qFunction(positionAgent._1)(positionAgent._2)
	val maxQ = currentActions.max
	if (verbose) {
	  println("==================")
	  for (i <- 0 until currentActions.length) println(directionDescription(i) + ": " + currentActions(i))
	  println("==================")
	}
	// we want to find all indices, with value maxQ
	val indicesWithMaxQ = currentActions.zipWithIndex.filter(_._1==maxQ).map(_._2)
	// then we randomly pick one of these indices
	Random.shuffle(indicesWithMaxQ.toList).head
  }
  private def runSimulation(grid: Array[Array[Char]], qFunction : Array[Array[Array[Double]]]): Array[Array[Array[Double]]] = {
    var positionAgent = (0, 0)
	var lastPositionAgent = positionAgent
	var changedQFunction = qFunction
	var stepCounter = 0
	var rewardAccumulated = 0
	
    while (grid(positionAgent._1)(positionAgent._2) != 'G') {
	  if (verbose) printSituation(positionAgent)
	  val direction = getDirection(positionAgent, qFunction)
	  if (verbose) println("Want to go " + directionDescription(direction))
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
      val (nextPositionAgent, reward) = evaluateAction(positionAgent, grid, changedQFunction, direction, possibleNewPositionAgent)
	  val nextDirection = getDirection(nextPositionAgent, changedQFunction)
	  if (verbose) println("Changing " + changedQFunction(positionAgent._1)(positionAgent._2)(direction) + " to " + changedQFunction(positionAgent._1)(positionAgent._2)(direction) + " + " + alpha + "*(" + reward + " + " + gamma*changedQFunction(nextPositionAgent._1)(nextPositionAgent._2)(nextDirection) + " + " + changedQFunction(positionAgent._1)(positionAgent._2)(direction) + ") = " + (changedQFunction(positionAgent._1)(positionAgent._2)(direction) + alpha*(reward + gamma*changedQFunction(nextPositionAgent._1)(nextPositionAgent._2)(nextDirection) + changedQFunction(positionAgent._1)(positionAgent._2)(direction))))
	  changedQFunction(positionAgent._1)(positionAgent._2)(direction) = changedQFunction(positionAgent._1)(positionAgent._2)(direction) + alpha*(reward + gamma*changedQFunction(nextPositionAgent._1)(nextPositionAgent._2)(nextDirection) + changedQFunction(positionAgent._1)(positionAgent._2)(direction))
	  positionAgent = nextPositionAgent
	  stepCounter = stepCounter + 1
	  rewardAccumulated = rewardAccumulated + reward
    }
	if (verbose) {
          println("Took " + stepCounter + " steps")
	  println("Earned " + rewardAccumulated + " reward")
        } else {
          println(stepCounter)
        }
	changedQFunction
  }
  
  def evaluateAction(positionAgent : (Int, Int), grid : Array[Array[Char]], qFunction : Array[Array[Array[Double]]], direction : Int, newPositionAgent : (Int, Int)) : ((Int, Int), Int) = {
     if ((0 until grid.length).contains(newPositionAgent._1) && (0 until grid(0).length).contains(newPositionAgent._2) && grid(newPositionAgent._1)(newPositionAgent._2) != 'X') {
	   val reward = if (grid(newPositionAgent._1)(newPositionAgent._2) == 'G') 100 else -1;
       (newPositionAgent, reward)
     } else {
	   (positionAgent, -1)
	 }
  }
}
