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
import java.util.Scanner;
public class B0744132_04 {
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
