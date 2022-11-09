package com.fm.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fm.member.model.MemberDto;
//DB와 관련된 작업을 저장하는 곳이라 레파지토리라는 어노테이션을 붙여야 한다.
@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.fm.member.";
	
	public List<MeberDto> memberSelectList(String searchOption,
			String keyword, int start, int end){
		Map<String, Object> map = new HashMap<>();
		
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList(namespace + "memberSelectList",map);
	}
	public MemberDto memberExist(String email, String password) {
		HashMap<String, Object> map = new HashMap<>();
		
	}
	
	public MemberDto memberSelectOne(int no);
	public int memberInsertOne(MemeberDto memberDto);
	int memberUpdateOne(MemberDto memberDto);
	

	

	
	
}
