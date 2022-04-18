package com.hi.trip.survey;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class SurveyDAO {

	@Autowired
	SqlSessionTemplate my; //의존성주입(DI)
	
	public List<SurveyVO> surveyList() {
		return my.selectList("survey.list");
	}
	public SurveyVO surveyReadOne(SurveyVO vo) {
		return my.selectOne("survey.readone", vo);
	}
	public int surveyDelete(SurveyVO vo) {
			return my.delete("survey.delete", vo); 
	}
	public int surveyCreate(SurveyVO vo) {
		return my.insert("survey.create", vo);
	}
	public int surveyUpdate(SurveyVO vo) {
		return my.update("survey.update", vo);
	}
}
