package com.fm.util;

import java.util.UUID;

public class CommonUtils {
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
//	현재날짜를 밀리타임으로 바꿔서 해당 값을 통해 랜덤을 정하는게 카카오나 다른 대기업이 사용하는 방식
}
