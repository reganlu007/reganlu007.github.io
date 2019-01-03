# 作業解答一覽

## 3
```
class	B0000000__03 {
	public	static void main(String[] args) {
		double h = 160, w = 60, bmi = w * 10000 / h / h;
		System.out.print("我的學號是 B0000000，身高 "+ h +" 公分，體重 "+ w +" 公斤，bmi 為 "+ bmi);
	}
}
```
## 4
```
import	java.util.Scanner;
class	B0000000__04 {
	public	static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("請輸入男生人數："); int m = sc.nextInt();
		System.out.print("請輸入女生人數："); int f = sc.nextInt();
		System.out.print("本班有男生 "+ m +" 人，女生 "+ f +" 人，總人數 "+ (m + f) +" 人。\n" + 
			"男生比例為 "+ m * 100.0 / (m + f) +"%，" +
			"女生比例為 "+ f * 100.0 / (m + f) +"%。");
	}
}
```
## 5
```
import	javax.swing.JOptionPane;
class	B0000000__05 {
	public	static void main(String[] args) {
		int qty = Integer.valueOf(JOptionPane.showInputDialog("請輸入購買數量")), price = 100;
		JOptionPane.showMessageDialog(null,
			"您購買" + qty + "件商品，原價為" + qty * price + "元，折扣後價格為" + qty * price *
			(qty >= 100 ? 0.5 : qty >= 50 ? 0.6 : qty >= 20 ? 0.7 : qty >= 10 ? 0.8 : 1) + "元");
	}
}
```
## 6
```
import	java.util.Scanner;
class	B0000000__06 {
	public	static void main(String[] args) {
		Scanner	sc = new Scanner(System.in);
		System.out.print("請輸入方案：　　");
		String	plan = sc.next();
		System.out.print("請輸入使用時數：");
		double	time = sc.nextDouble(), fee = 0;
		switch (plan){
			case "A": case "a": fee =  9.95 + Math.max(0,(time - 10) * 2); break;
			case "B": case "b": fee = 13.95 + Math.max(0, time - 20);      break;
			case "C": case "c": fee = 19.95;}
		System.out.println("您這個月的網路費用為："+ fee +" 元");
	}
}
```
## 7
```
import	java.util.Scanner;
class	B0000000__07 {
	public	static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.printf("輸入搜尋範圍：");
		int min = sc.nextInt(), max = sc.nextInt();
		System.out.printf("輸入Ｎ：　　　");
		int num = sc.nextInt(), sum = 0;
		System.out.printf("%d 和 %d 之間，%d 的倍數有：", min, max, num);
		for(int	i = Math.max(min - min % num, num) - num; i + num <= max; sum += i)
			System.out.printf("%d、", i += num);
		System.out.printf("\b\b，總和為 %d。",  sum);
	}
}
```
## 8
```
class	B0000000__08 {
	public	static void main(String[] args) {
		String s = "";
		int man = 0, com = 0, tie = 0;
		for(int i = 0; i < 10;){
			int d_1 = (int)(Math.random() * 6) + 1, d_2 = (int)(Math.random() * 6) + 1;
			if (d_1 >  d_2){com++; s = "電腦獲勝";}
			if (d_1 <  d_2){man++; s = "玩家獲勝";}
			if (d_1 == d_2){tie++; s = "平手　　";}
			System.out.printf("第 %2d 次：1 號骰子：%d\t2 號骰子：%d\t%s\n", ++i, d_1, d_2, s);
		}
		System.out.printf("\n比賽結果統計：電腦獲勝 %d 次，玩家獲勝 %d 次，雙方平手 %d 次。",
			com, man, tie);
	}
}
```
## 9
```
import	java.util.Scanner;
import	java.io.*;
class	B0000000__09 {
		static void pt  (PrintWriter pw, String s){pw.print(s); System.out.print(s);}
	public	static void main(String[]  args) throws IOException{
		PrintWriter pw = new PrintWriter("B0000000.txt");
		Scanner	    sc = new Scanner(System.in);
		String     c[] = {"", "紅色", "綠色", "藍色", "橘色", "黃色"};
		int        com = 0, man = 0 , ya = 0;
		for (int i = 1; i <= 5; i++){
			pt(pw, "第 "+ i +" 次：\r\n請選擇顏色 (1：紅色，2：綠色，3：藍色，4：橘色，5：黃色)：");
			pt(pw, "電腦選擇顏色："+ c[com = (int)(Math.random() * 5) + 1] +
			     "\t玩家選擇顏色："+ c[man = sc.nextInt()] +
			     "\t玩家答" + (com == man ? "對" : "錯") +"\r\n");
			if(com == man) ya++;
		}
		pt(pw, "\r\n遊戲結束：玩家總共答對 "+ ya +" 次。");
		pw.close();
	}
}
```
## 10
```
import	java.util.Scanner;
class	B0000000__10 {
	public	static void main (String[] args){
		Scanner sc = new Scanner(System.in);
		System.out.print("輸入：");
		calculate(sc.nextInt(), sc.nextInt(), sc.next());
	}
	static	void calculate(double a, double b, String c){
		System.out.printf("輸出：%.0f %s %.0f = ", a, c, b);
		switch(c) {
			case "+": a += b; break;
			case "-": a -= b; break;
			case "*": a *= b; break;
			case "/": a /= b; break;
			case "%": a %= b; break;
			case "^": a  = Math.pow(a, b); break;
		}
		System.out.print(a);
	}
}
```
## 11
```
class	B0000000__11 {
	public	static void main(String[] args){
		System.out.print("輸入："); int x = new java.util.Scanner(System.in).nextInt();
		System.out.print("輸出：2 ~ " + x + " 間 包含的質數有：2");
		for(int i = 3; i <= x; i += 2) if(isPrime(i)) System.out.print("、"+ i);
	}
	static	boolean isPrime(int x){
		for(int i = 3; i <= Math.sqrt(x); i += 2)
			if(x % i == 0) return false;
		return true;
	}
}
```
## 12
```
import	java.util.*;
class	B0000000__12 {
	public	static void main(String[] args){
		Scanner s = new Scanner (System.in);
		Random  r = new Random();
		int com[] = new int[5], man[]= new int[com.length], correct = 0;
		System.out.print("輸入 "+ com.length +" 個範圍 1 ~ 4 的整數：");
		for(int i = 0; i < com.length; i++){
			com[i] = r.nextInt(4)+ 1;
			man[i] = s.nextInt( );
			if (com[i] == man[i]) correct++;
		}
		System.out.print("\n電腦產生的數字："); for(int i : com) System.out.print(i +" ");
		System.out.print("\n玩家輸入的數字："); for(int i : man) System.out.print(i +" ");
		System.out.print("\n玩家答對的題數：" + correct);
	}
}
```
## 13
```
class	B0000000__13 {
	public	static void main(String[] args){	
		String a[] = {(""+ Math.random()).substring(2, 10),
			"頭","二","三","四","五","六",
			"二十萬","四萬","一萬","四千","一千","兩百"};
		int i = a[0].length();
		System.out.printf("電腦產生的發票號碼: %s\n使用者輸入發票號碼: ", a[0]);
		a[0] += new java.util.Scanner(System.in).next();
		while(i-- > 0 && a[0].charAt(i) == a[0].charAt(i+8));
		System.out.print(++i < 6 ? "恭喜您中了"+ a[++i] +"獎，獲得獎金"+ a[i+6] +"元" : "很遺憾，這次沒有中獎");
	}
}
```
## 14
```
class	B0000000__14 {
	public	static void main(String[] args){
		int row = 6, col = 5, score[][] = new int[row][col];
		System.out.print("學生\t國文\t英文\t數學\t自然\t社會\t平均");
		for(int i = 0; i < row; i++){
			System.out.printf("\n%d 號", i + 1);
			int sum = 0;
			for(int j = 0; j < col; j++){
				System.out.printf("\t%3d", score[i][j] = (int)(Math.random()*101));
				sum += score[i][j];
			}
			System.out.printf("\t%.1f", 1. * sum / col);
		}
		System.out.print("\n最高");
		for(int j = 0; j < col; j++){
			int max = 0;
			for(int i = 0; i < row; i++)
				max = score[i][j] > score[max][j] ? i : max;
			System.out.printf("\t%d 號",++max);
		}
	}
}
```
## 15
```
import	java.util.*;
class	B0000000__15 {
	public	static void main(String[] args){
		int x[] = new int[10];
		ArrayList al = new ArrayList();
		for (int i = 0; i < x.length; i++)
			al.add(func(i, x[i]=new Random().nextInt(100)+1, al), x[i]);
		System.out.printf("前：%s\n後：%s\n",Arrays.toString(x), al);
	}
	public	static int  func(int i, int x, ArrayList al){
		for (int  j = 0; j < i; j++) if(x < (int)al.get(j)) return j; return i;
	}
}
```
## 1/3 練習
```
import	java.util.*;
class	j {
	public	static void main(String[] args){
// Q1
		System.out.print("In : ");
		String s = new Scanner(System.in).next();
		int sum  = 0;
		for(int i= 0; i < s.length(); i++)
			sum += Math.pow(s.charAt(i) - '0', 2);
		System.out.println("Out: "+ sum);
		
// Q2
		int x[][] = new int[5][5], sum1 = 0, sum2 = 0;
		for(int i = 0; i < 5; i++){
			for(int j = 0; j < 5; j++){
				System.out.print("\t"+ (x[i][j] = new Random().nextInt(10)));
				if(i == j) sum1 += x[i][j];
				if(i+j==4) sum2 += x[i][j];
			}
			System.out.println();
		}
		System.out.println("主："+ sum1+"、次："+ sum2);
	}
}
```
# 期中上機參考答案
```
import	java.util.Scanner;
class	B0000000__midterm {
	public	static void main(String[] args){
		Scanner sc = new Scanner (System.in);	
/*	Q1
		System.out.printf("長方形的長度："); int l = sc.nextInt();
		System.out.printf("長方形的寬度："); int w = sc.nextInt();
		System.out.printf("長方形的面積：%d" , l * w);
*/		
/*	Q2
		System.out.printf("輸入三個整數："); int a = sc.nextInt(), b = sc.nextInt(), c = sc.nextInt();
		System.out.printf("%d %s是 %d 和 %d 的公因數 " , c,
			(a % c == 0 && b % c == 0 ? "" : "不"), a, b);
*/
/*	Q3
		System.out.printf("輸入整數秒數："); int sec = sc.nextInt();
		System.out.printf("%d 秒為 %d 天 %d 時 %d 分 %d 秒", sec,
			sec / 86400, sec % 86400 / 3600, sec % 3600 / 60, sec % 60);
*/	
/*	Q4
		System.out.printf("輸入支票張數："); int x = sc.nextInt();
		System.out.printf("帳戶維持費用：%d 元",
			x *(x < 20 ? 10 : x < 40 ? 8 : x < 60 ? 6 : 4)+ 100);
*/	
/*	Q5
		for(int i = 1; i <= 15; i++)
			System.out.printf("%3d 公斤的物品總費用為 %3d 元\n", i,
				Math.min(i, 5)* 30 + Math.max(i - 5, 0)* 20 + (i <= 10 ? 50 : 0));
*/
	}
}
```
