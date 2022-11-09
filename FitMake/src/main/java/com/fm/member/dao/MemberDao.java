package com.fm.member.dao;

import java.util.List;

public interface MemberDao {
	public List<MeberDto> memberSelectList(String searchOption,
			String keyword, int start, int end);
	public MemberDto memberExist(String email, String password);
	public MemberDto memberSelectOne(int no);
	public int memberInsertOne(MemeberDto memberDto);
	int memberUpdateOne(MemberDto memberDto);
}
