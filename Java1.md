# 作業解答一覽

3.

```
public class B0000000_03 {
	public static void main(String[] args) {
		double	h   = 200,
			w   = 100,
			bmi = w * 10000 / h / h;
		System.out.print("我的學號是 B0000000，" +
			"身高 "+ height +" 公分，" +
			"體重 "+ weight +" 公斤，" +
			"bmi 為 "+ bmi);
	}
}
```

4.

```
import java.util.Scanner;
public class B0000000_04 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("請輸入男生人數:");
		int m = sc.nextInt();
		System.out.print("請輸入女生人數:");
		int f = sc.nextInt();
		System.out.print("本班有" + 
			"男生 "+ m +" 人，" + 
			"女生 "+ f +" 人，" + 
			"總人數 "+ (m + f) +" 人。\n" + 
			"男生比例為 "+ m * 100 / (m + f) +"%，" +
			"女生比例為 "+ f * 100 / (m + f) +"%。");
	}
}
```

5.

```
import javax.swing.JOptionPane;
public class B0000000_05 {
	public static void main(String[] args) {
		int qty = Integer.valueOf(JOptionPane.showInputDialog("請輸入購買數量")), price = 100;
		JOptionPane.showMessageDialog(null,
			"您購買" + qty + "件商品，"+
			"原價為" + qty * price + "元，"+
			"折扣後價格為" + qty * price *
			(qty >= 100 ? 0.5 :
			 qty >=  50 ? 0.6 : 
			 qty >=  20 ? 0.7 : 
			 qty >=  10 ? 0.8 : 1) + "元");
	}
}
```

6.

```
public class B0000000_06 {
	public static void main(String[] args) {
	}
}
```

7.

```
import java.util.Scanner;
public class B0000000_07 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.printf("輸入搜尋範圍：");
		int min = sc.nextInt(), max = sc.nextInt();
		System.out.printf("輸入 N：      ");
		int num = sc.nextInt(), sum = 0;
		System.out.printf("%d 和 %d 之間，%d 的倍數有：", min, max, num);
		for(int	i = Math.max(min - min % num, num) - num;
			i + num <= max;
			sum += i)
			System.out.printf("%d、", i += num);
		System.out.printf("\b總和為 %d。", sum);
	}
}
```

8.

```
public class B0000000_08 {
	public static void main(String[] args) {
	}
}
```
