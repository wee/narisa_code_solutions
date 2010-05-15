// orginal code by Revoluter http://www.narisa.com/forums/index.php?showtopic=27436&view=findpost&p=129349
// refactored by sWeetCorn
import java.io.*;
import java.util.*;

public class RomanNumber
{
    private List<DecimalRomanPair> decimalRomanPairs;
    private String fileName;
    
    public RomanNumber(String fileName) {
    	this.fileName = fileName;
    	initializeDecimalRomanPairs();
    }

    public static void main(String [] args) throws Exception {
    	RomanNumber romanNumber = new RomanNumber("input4.txt");
    	romanNumber.printNumbers();
    }
    
    public void printNumbers() throws NumberFormatException, IOException {
        BufferedReader bufferedReady = new BufferedReader(new FileReader(fileName));
        String line = null;
        while ((line = bufferedReady.readLine()) != null) {
            System.out.println(line + " = " + romanNotation(Integer.valueOf(line)));
        }
    }
    
	private void initializeDecimalRomanPairs() {
		decimalRomanPairs = new ArrayList<DecimalRomanPair>();
        decimalRomanPairs.add(new DecimalRomanPair(1, "I", true));
        decimalRomanPairs.add(new DecimalRomanPair(5, "V", false));
        decimalRomanPairs.add(new DecimalRomanPair(10, "X", true));
        decimalRomanPairs.add(new DecimalRomanPair(50, "L", false));
        decimalRomanPairs.add(new DecimalRomanPair(100, "C", true));
        decimalRomanPairs.add(new DecimalRomanPair(500, "D", false));
        decimalRomanPairs.add(new DecimalRomanPair(1000, "M", true));
        decimalRomanPairs.add(new DecimalRomanPair(5000, "Dummy", true));
	}
    
    protected String romanNotation(int decInput)
    {
        StringBuilder result = new StringBuilder();
        while(decInput != 0)
        {
            for (int i = decimalRomanPairs.size() - 1; i >= 0; i--)
            {
                DecimalRomanPair currentPair = decimalRomanPairs.get(i);
                int divValue = decInput / currentPair.decimal;
                int modValue = decInput % currentPair.decimal;
                if (divValue > 0 && divValue < 4 && modValue == 0)
                {
                    appendRomanNumber(result, currentPair.roman, divValue);
                    decInput -= currentPair.decimal * divValue;
                    break;
                }
                else if (divValue > 0)
                {
                    DecimalRomanPair upperPair = decimalRomanPairs.get(i + 1);
                    DecimalRomanPair upperPrecedePair = getPrecedePair(i + 1);
                    if ((upperPair.decimal - upperPrecedePair.decimal) <= decInput)
                    {
                        result.append(upperPrecedePair.roman + upperPair.roman);
                        decInput -= upperPair.decimal - upperPrecedePair.decimal;
                        break;
                    }
                    else
                    {
                        result.append(currentPair.roman);
                        DecimalRomanPair currentPrecedePair = getPrecedePair(i);
                        decInput -= currentPair.decimal;
                        divValue = decInput / currentPrecedePair.decimal;
                        if (divValue > 0 && divValue < 4)
                        {
                            appendRomanNumber(result, currentPrecedePair.roman, divValue);
                            decInput -= currentPrecedePair.decimal * divValue;
                        }
                        break;
                    }
                }
            }
        }
        return result.toString();
    }
    
    protected DecimalRomanPair getPrecedePair(int pairIndex)
    {
        DecimalRomanPair result = null;
        for (int i = pairIndex - 1; i >= 0; i--) {
            if (decimalRomanPairs.get(i).precede) {
                result = decimalRomanPairs.get(i);
                break;
            }
        }
        return result;
    }
    
    protected static void appendRomanNumber(StringBuilder result, String romanNumber, int times) {
        for (int i = 0; i < times; i++) result.append(romanNumber);
    }
    
    public class DecimalRomanPair
    {
        public int decimal;
        public String roman;
        public boolean precede;
        public DecimalRomanPair(int decimal, String roman, boolean precede) {
            this.decimal = decimal;
            this.roman = roman;
            this.precede = precede;
        }
    }
}