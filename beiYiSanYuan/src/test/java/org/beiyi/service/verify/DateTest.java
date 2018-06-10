package org.beiyi.service.verify;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.skynet.frame.util.date.DateUtil;

public class DateTest {
	public static void main(String[] args) throws ParseException {
		/*Date bornDate = DateUtil.parseToDate("1994/3/6");
		System.out.println(bornDate);
		boolean v = DateUtil.dateInSection(bornDate, "27~28");
		System.out.println(v);*/
//		date = DateUtil.parseToDate("2017/3/9 6:53:34");
//		System.out.println(date);
		/*String[] test = {"成asdf","老年","虚弱","6至17岁儿童"};
		for (String t : test) {
			System.out.println(t+"\t"+t.matches(".*成人.*|.*年龄.*|.*岁.*|.*儿童.*|*老年*"));
		}*/
		for (int i = 0; i < 10000; i++) {
			System.out.println(i);
			try {
				Thread.sleep(10000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
