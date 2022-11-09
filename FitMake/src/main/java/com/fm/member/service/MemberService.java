package com.fm.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.member.dao.MeberDto;
import com.fm.member.dao.MemeberDto;
import com.fm.member.model.MemberDto;

public interface MemberService {
	public List<MeberDto> memberSelectList(String searchOption,
			String keyword, int start, int end);
	public MemberDto memberExist(String email, String password);
	public MemberDto memberSelectOne(int no);
	public int memberInsertOne(MemeberDto memberDto);
	int memberUpdateOne(MemberDto memberDto);
	

}
