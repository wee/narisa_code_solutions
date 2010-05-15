public class TextDiamon {

    public static void run(String[] args) {
        long startTime = System.nanoTime();
        int line = Integer.parseInt(args[0]);
        int col = (line%2!=0)?line:line-1;
        char[][] lines = new char[line][col];
        int hline = Math.round(line/2.0f);
        int hcol = Math.round(col/2.0f);
        for(int i=0;i<hline;i++) {
            for(int j=0;j<hcol;j++) {
                if(j==hline-(i+1)) {
                    lines[i][j]                 = '*';
                    lines[i][col-1-j]            = '*';
                    lines[line-1-i][col-1-j]    = '*';
                    lines[line-1-i][j]            = '*';
                } else {
                    lines[i][j]                 = '-';
                    lines[i][col-1-j]            = '-';
                    lines[line-1-i][col-1-j]    = '-';
                    lines[line-1-i][j]            = '-';
                }
            }
        }
        
        long estimatedTime1 = System.nanoTime() - startTime;
        for(int i=0;i<line;i++) {
            System.out.println((char[])lines[i]);
        }
        long estimatedTime2 = System.nanoTime() - startTime;
        
        System.out.printf("Calculate time : %.9f sec.\n" , new Object[]{estimatedTime1/1000000000.0d});
        System.out.printf("    Total time : %.9f sec.\n" , new Object[]{estimatedTime2/1000000000.0d});
        System.out.println("\n\n");
    }
    
    public static void main(String[] args) {
        if(args.length > 0) {
            run(args);
        } else {
            for(int i=3;i<20;i++) {
                run(new String[]{String.valueOf(i)});
            }
        }
    }
}
