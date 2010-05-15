def findPrimeFactors(number : Int) : List[Int] = {
  val first_prime_or_none = (2 until Math.sqrt(number)).inclusive.find { i => number % i == 0 }
  if (first_prime_or_none != None) {
    return first_prime_or_none.get :: findPrimeFactors(number / first_prime_or_none.get)
  }
  number :: Nil
}

(2 until 100).inclusive.foreach { 
    number => println(  "Prime factors of " + number + " is " +
                        findPrimeFactors(number).removeDuplicates.mkString("[", ", ", "]") )
}

