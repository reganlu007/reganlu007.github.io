# 作業解答一覽

3.
```
class	B0000000__03 {
	public	static void main(String[] args) {
		double h = 160, w = 60, bmi = w * 10000 / h / h;
		System.out.print("我的學號是 B0000000，身高 "+ h +" 公分，體重 "+ w +" 公斤，bmi 為 "+ bmi);
	}
}
```
4.
```
import	java.util.Scanner;
class	B0000000__04 {
	public	static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("請輸入男生人數：");
		int m = sc.nextInt();
		System.out.print("請輸入女生人數：");
		int f = sc.nextInt();
		System.out.print("本班有男生 "+ m +" 人，女生 "+ f +" 人，總人數 "+ (m + f) +" 人。\n" + 
			"男生比例為 "+ m * 100.0 / (m + f) +"%，" +
			"女生比例為 "+ f * 100.0 / (m + f) +"%。");
	}
}
```
5.
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
6.
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
7.
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
8.
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
# 期中上機參考答案

```
import	java.util.Scanner;
class	B0000000__midterm {
	public	static void main(String[] args){
		Scanner sc = new Scanner (System.in);	
/*	Q1
		System.out.printf("長方形的長　："); int l = sc.nextInt();
		System.out.printf("長方形的寬　："); int w = sc.nextInt();
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
