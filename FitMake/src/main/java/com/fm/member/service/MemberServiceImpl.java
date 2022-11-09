package com.fm.member.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.transaction.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fm.member.dao.MemberDao;
import com.fm.member.model.MemberDto;
import com.fm.util.FileUtils;

@Service
public class MemberServiceImpl implements MemberService{
	
	private static final Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	public MemberDao memberDao;
	
	


}
