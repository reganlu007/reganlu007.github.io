# 同學範例解答

3.
```
public	class	B0744104_03 {
	public	static void main(String[] args) {
		float height;
		float weight;
		float bmi;
		height = 180;
		weight =  57;
		bmi    = weight/(height * height /10000);
		System.out.print("我的學號是B0744104，");
		System.out.print("身高"+ height +"公分，");
		System.out.print("體重"+ weight +"公斤，");
		System.out.print("bmi為"+ bmi );
	}
}
```
4.
```
import	java.util.Scanner;
public	class B0744132_04 {
	public static void main(String[] args) {
		int male, female, total;
		Scanner keyboard = new Scanner(System.in);
		System.out.print("請輸入男生人數:");
		male = keyboard.nextInt();
		System.out.print("請輸入女生人數:");
		female = keyboard.nextInt();
		total = male + female;
		System.out.println("本班有男生" + male + "人,女生" + female + "人,總人數" + total + "人。");
		System.out.print("男生比例為" + (male * 100.0) / total + "%,女生比例為" + (female * 100.0) / total + "%。");
	}
}
```
5.
```
import	javax.swing.JOptionPane;
public	class	B0744148_05 {
	public	static void main(String[] args) {
		double per;
		double der;
		String wee = JOptionPane.showInputDialog("請輸入購買數量");
		der = Double.parseDouble(wee);
		if (der<10){
			per = der*100;
			JOptionPane.showMessageDialog(null,"您購買"+der+"件商品，原價為"+der*100+"元，折扣後價格為"+der*100+"元");
		}
		else if (der<19){
			per = der*100*0.8;
			JOptionPane.showMessageDialog(null,"您購買"+der+"件商品，原價為"+der*100+"元，折扣後價格為"+der*100*0.8+"元");
		}
		else if (der<49){
			per = der*100*0.7;
			JOptionPane.showMessageDialog(null,"您購買"+der+"件商品，原價為"+der*100+"元，折扣後價格為"+der*100*0.7+"元");
		}
		else if (der<99){
			per = der*100*0.6;
			JOptionPane.showMessageDialog(null,"您購買"+der+"件商品，原價為"+der*100+"元，折扣後價格為"+der*100*0.6+"元");
		}
		else if (der>=100){
			per = der*100*0.5;
			JOptionPane.showMessageDialog(null,"您購買"+der+"件商品，原價為"+der*100+"元，折扣後價格為"+der*100*0.5+"元");
		}
		System.exit(0);
	}
}
```
6.
```
import	java.util.Scanner;
public	class b0744122_06 {
	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in);
		System.out.print("請選擇方案:");
		String choice = keyboard.next();
		System.out.print("請輸入使用時間:");
		double time = keyboard.nextDouble();
		switch (choice) {
			case "A": case "a": time =  9.95 + (time <= 10 ? 0 : (time - 10) * 2); break;
			case "B": case "b": time = 13.95 + (time <= 20 ? 0 : time - 20); break;
			case "C": case "c": time = 19.95; break;
		}
		System.out.print("您這個月的網路費用為" + time + "元");
	 }
}
```
7.
```
import	java.util.Scanner;
public	class B0744110_07 {
	public static void main(String[] args) {
		int a,b,n,index,output,sum;
		Scanner keyboard = new Scanner(System.in);
		System.out.println("輸入搜尋範圍:");
		a = keyboard.nextInt();
		b = keyboard.nextInt();
		System.out.print("輸入N:");
		n = keyboard.nextInt();
		index=1;
		sum=0;
		System.out.print(a+"和"+b+"之間，"+n+"的倍數有:");
		while(n*index<=b)
		{
			output=n*index;
			sum+=output;
			index++;
			System.out.printf(output+" ");
		}
		System.out.print("，總和有"+sum+"。");
	}
}
```
8.
```
import	java.util.Random;
public	class B0744112_08 {
	public static void main(String[] args) {
		int computer,player,time,sumC,sumP,sumB;
		sumC = 0;
		sumP = 0;
		sumB = 0;
		Random randomnumber = new Random();
		for ( time = 1 ; time<=10 ; time++) 
		{
			computer = randomnumber.nextInt(6)+1;
			player   = randomnumber.nextInt(6)+1;
			if (computer>player) {
				System.out.println("第"+time+"次"+"\t"+"1號骰子:"+computer+"\t"+"2號骰子："+player+"\t"+"電腦獲勝");
				sumC++;
			} else if (computer<player) {
				System.out.println("第"+time+"次"+"\t"+"1號骰子:"+computer+"\t"+"2號骰子："+player+"\t"+"玩家獲勝");
				sumP++;
			} else {
				System.out.println("第"+time+"次"+"\t"+"1號骰子:"+computer+"\t"+"2號骰子："+player+"\t"+"雙方平手");
				sumB++;
			}
		}
		System.out.println("比賽結果統計：電腦獲勝"+sumC+"次，玩家獲勝"+sumP+"次，雙方平手"+sumB+"次。");
	}
}
```
# 期中上機參考答案
```
import	java.util.Scanner;
class	B0000000__midterm {
	public	static void main(String[] args){
	/* Q1
		int A,B;
		Scanner key = new Scanner(System.in);
		System.out.println("請輸入長方形的底：");
		A = key.nextInt();
		System.out.println("請輸入長方形的高：");
		B = key.nextInt();
		System.out.printf("長方形的面積為 %d",A*B);
	*/
	/* Q2
		int a, b, c;		
		Scanner	key = new Scanner(System.in);
		System.out.println("請輸入三個整數：");
		a = key.nextInt();
		b = key.nextInt();
		c = key.nextInt();			
		if ((a%c == 0)&&(b%c == 0))
			System.out.printf("%d  是%d和%d的公因數。",c,a,b);
		else
			System.out.printf("%d不是%d和%d的公因數。",c,a,b);
	*/
	/* Q3		
		Scanner keyboard = new Scanner(System.in);
		int sec;
		int min;
		int hr;
		int day;
		System.out.println("輸入秒數:");
		sec = keyboard.nextInt();
		System.out.print(sec+"秒為"+ sec/86400 +"天"+ sec%86400/3600 +"時"+ sec%86400%3600/60 +"分"+ sec%86400%3600%60 +"秒");
	*/
	/* Q4
		int a;		
		Scanner key = new Scanner(System.in);		
		System.out.print("輸入支票張數：");
		a = key.nextInt();		
		if(a<20)
			System.out.printf("帳戶維持費用為%d元",a*10+100);
		else if(a<40)
			System.out.printf("帳戶維持費用為%d元",a* 8+100);
		else if(a<60)
			System.out.printf("帳戶維持費用為%d元",a* 6+100);
		else
			System.out.printf("帳戶維持費用為%d元",a* 4+100);
	*/		
	/* Q5
		int weight;
		for (weight = 1; weight <= 15; weight++) {
			if (weight <= 5)
				System.out.printf("%d公斤的物品總費用為：%d元", weight, weight * 30 + 50);
			else if (weight <= 10)
				System.out.printf("%d公斤的物品總費用為：%d元", weight, 5 * 30 + (weight - 5) * 20 + 50);
			else
				System.out.printf("%d公斤的物品總費用為：%d元", weight, 5 * 30 + (weight - 5) * 20);
			System.out.println("");
		}
	*/
	}
}
```
