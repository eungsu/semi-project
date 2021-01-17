package kr.co.hta.shop.util;

import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateUtils {
	
	/**
	 * 지정된 날짜가 오늘인지 여부를 반환한다.
	 * @param date 날짜
	 * @return 동일한 날인 경우 true를 반환한다.
	 */
	public static boolean isToday(Date date) {
		if (date == null) {
			throw new IllegalArgumentException("Date는 null값을 허용하지 않음");
		}
		
		return isWithinDays(date, 0);
	}
		
	/**
	 * 지정한 날짜가 오늘을 기준으로 지정된 날짜 이내의 날짜인지 여부를 반환한다.
	 * @param date 날짜
	 * @param days 날 수, 0인 경우 1일 이내
	 * @return 지정된 날짜가 오늘을 기준으로 지정된 날짜부터 오늘 사이에 속하는 날짜면 true를 반환한다.
	 */
	public static boolean isWithinDays(Date date, int days) {
		if (date == null) {
			throw new IllegalArgumentException("Date는 null값을 허용하지 않음");
		}
		Period period = Period.between(dateToLocalDate(date), LocalDate.now());
		
		return period.getDays() >= 0 && period.getDays() <= days;
	}
	
	/**
	 * 지정한 날짜가 오늘을 기준으로 1주일 이내의 날짜인지 여부를 반환한다.
	 * @param date 날짜
	 * @return 지정된 날짜가 오늘을 기준으로 1주일 전부터 오늘 사이에 속하는 날짜면 true를 반환한다.
	 */
	public static boolean isWithinOneWeek(Date date) {
		if (date == null) {
			throw new IllegalArgumentException("Date는 null값을 허용하지 않음");
		}
		
		return isWithinWeeks(date, 0);
	}
	
	/**
	 * 지정한 날짜가 오늘을 기준으로 지정된 주 이내의 날짜인지 여부를 반환한다
	 * @param date 날짜
	 * @param weeks 주, 0인 경우 1주일 이내
	 * @return 지정된 날짜가 오늘을 기준으로 지정된 주 전부터 오늘 사이에 속하는 날짜면 true를 반환한다.
	 */
	public static boolean isWithinWeeks(Date date, int weeks) {
		if (date == null) {
			throw new IllegalArgumentException("Date는 null값을 허용하지 않음");
		}
		Period period = Period.between(dateToLocalDate(date), LocalDate.now());
		
		return period.getDays() >= 0 && period.getDays() <= weeks*7;
	}
	
	/**
	 * 지정한 날짜가 오늘을 기준으로 1개월 이내의 날짜인지 여부를 반환한다.
	 * @param date 날짜
	 * @return 지정된 날짜가 오늘을 기준으로 1개월 전부터 오늘 사이에 속하는 날짜면 true를 반환한다.
	 */
	public static boolean isWithinOneMonth(Date date) {
		return isWithinMonths(date, 0);
	}
	
	/**
	 * 지정한 날짜가 오늘을 기준으로 지정된 개월 이내의 날짜인지 여부를 반환한다.
	 * @param date 날짜
	 * @param months 개월 수, 0인 경우 1개월 이내인지 
	 * @return 지정된 날짜가 오늘을 기준으로 지정된 개월 전부터 오늘 사이에 속하는 날짜면 true를 반환한다.
	 */
	public static boolean isWithinMonths(Date date, int months) {
		if (date == null) {
			throw new IllegalArgumentException("Date는 null값을 허용하지 않음");
		}
		Period period = Period.between(dateToLocalDate(date), LocalDate.now());
		return period.getMonths() >= 0 && period.getMonths() <= months;
	}
	
	/**
	 * java.utilDate를 java.time.LocalDate로 변환한다.
	 * @param date 날짜
	 * @return LocalDate
	 */
	public static LocalDate dateToLocalDate(Date date) {
		return Instant.ofEpochMilli(date.getTime())
				.atZone(ZoneId.systemDefault())
				.toLocalDate();
	}

	/**
	 * 날짜를 2000년 12월 31일 형식의 문자열로 반환한다.
	 * @param date 날짜
	 * @return "2000년 12월 31일" 형식의 문자열
	 */
	public static String dateToLocalDateString(Date date) {
		LocalDate localDate = dateToLocalDate(date);
		return localDate.format(DateTimeFormatter.ofPattern("yyyy년 M월 d일"));
	}
	
	/**
	 * 생일을 전달받아서 오늘을 기준으로 만 나이를 반환하는 메소드
	 * @param birth 생일
	 * @return 만 나이
	 */
	public static int getCurrentAge(Date birth) {
		if (birth == null) {
			throw new RuntimeException("birth는 null일 수 없습니다.");
		}
		
		return Period.between(dateToLocalDate(birth), LocalDate.now()).getYears();
	}
}
