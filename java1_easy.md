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
