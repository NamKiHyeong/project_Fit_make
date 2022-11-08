package com.fm.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.member.model.MemberDto;

public interface MemberDao {
	public List<MeberDto> memberSelectList(String searchOption,
			String keyword, int start, int end);
	public
}
