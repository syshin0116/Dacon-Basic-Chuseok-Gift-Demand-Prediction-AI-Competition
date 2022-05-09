package com.hi.trip.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.hi.trip.survey.SurveyVO;

@Component
public class MemberDAO {

	@Autowired
	SqlSessionTemplate my;
	
	public void create(MemberVO vo) 
	{
		my.insert("member.create", vo);
	}
	
	public MemberVO selectOneId(MemberVO vo)
	{
		return my.selectOne("member.oneId", vo);
	}
	
	public List<MemberVO> selectList() { //동수꺼에 추가
		return my.selectList("member.all");
	}
	
	public MemberVO selectOneIdx(MemberVO vo) {//동수꺼에 추가
		return my.selectOne("member.oneIdx", vo);
	}
	
	public MemberVO selectOneName(MemberVO vo)
	{
		return my.selectOne("member.oneName", vo);
	}
	
	public MemberVO loginHiTrip(MemberVO vo)
	{
		return my.selectOne("member.loginHiTrip", vo);
	}
	
	public MemberVO loginNaver(MemberVO vo)
	{
		return my.selectOne("member.loginNaver", vo);
	}
	
	
}