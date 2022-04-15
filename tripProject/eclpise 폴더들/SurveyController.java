package com.hi.trip.survey;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SurveyController {
	@Autowired
	SurveyDAO surveyDao;
	
	@RequestMapping("survey/surveyList")
	public void list(SurveyVO vo, Model model, HttpSession session) {
		// db Survey 테이블에서 VO 받아옴
		List<SurveyVO> surveyList = surveyDao.surveyList();
		int[] surveyIdxList = new int [surveyList.size()]; // surveyIdx개수에 따른 surveyIdxList생성
		for(int i = 0; i < surveyList.size(); i++) { //surveyIdx
			surveyIdxList[i] = surveyList.get(i).getSurvey_idx();
		}
		
		model.addAttribute("surveyList", surveyList);
	}
	
	
	@RequestMapping("survey/surveyReadOne")
	public void one(SurveyVO vo, Model model, HttpSession session) {
		SurveyVO vo2 = surveyDao.surveyReadOne(vo);
		model.addAttribute("readone", vo2);
		session.setAttribute("member_idx", 1);
		System.out.println("vo2:"+vo2);
	}

	@RequestMapping("survey/surveyDelete")
	public void delete(SurveyVO vo, Model model) {
		int result = surveyDao.surveyDelete(vo);
		model.addAttribute("surveyResult", result);
	}

	@RequestMapping("survey/surveyCreate")
	public void insert(SurveyVO vo, Model model) {

		int result = surveyDao.surveyCreate(vo);
		String text = "설문지 문제 등록 성공";
		if (result != 1) {
			text = "설문지 문제 등록 실패";
		}
		model.addAttribute("result", text);
	}

	@RequestMapping("survey/surveyUpdate")
	public void update(SurveyVO vo, Model model) {
		SurveyVO vo2 = surveyDao.surveyReadOne(vo);
		model.addAttribute("readone", vo2);
	}

	@RequestMapping("survey/surveyUpdate2")
	public void update2(SurveyVO vo, Model model) {
		// 수정하고 싶은 것이 있으면 수정처리 요청.
		int result = surveyDao.surveyUpdate(vo);
		String text = "설문지 수정 성공";
		if (result != 1) {
			text = "설문지 수정 실패";
		}
		model.addAttribute("result", text);
		model.addAttribute("readone", vo);
	}
}
