package com.hi.trip.itinerary;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hi.trip.member.MemberDAO;
import com.hi.trip.member.MemberVO;
import com.hi.trip.place.PlaceDAO;
import com.hi.trip.place.PlaceVO;
import com.hi.trip.survey.SurveyVO;
import com.hi.trip.surveyResult.SurveyResultVO;

@Controller
public class ItineraryController {
	
	@Autowired
	ItineraryDAOInter itineraryDao = new ItineraryDAO();
	
	@Autowired
	PlaceDAO placeDao = new PlaceDAO();
	
	@Autowired
	MemberDAO memberDao = new MemberDAO();
	
	@RequestMapping("itinerary/itineraryList")
	public void list(ItineraryVO vo, MemberVO memberVO, Model model, HttpSession session, @RequestParam(name = "pageNumber", required = false, defaultValue = "1") int pageNumber) { // 여행일정 게시판
//		int pageNum = 1; //기본은 1 페이지를 할당
//		try{pageNum = Integer.parseInt(request.getParameter("pageNumber"));}
//		catch(NumberFormatException e) {
//		System.out.println("Controller pageNum:"+pageNum);
//		System.out.println("첫번째 페이지" + e);
//		}
		
		List<ItineraryVO> itineraryList = itineraryDao.itineraryList(pageNumber); // Dao에서 VO형태로 수신
		List<MemberVO> memberList = memberDao.selectList();
		Boolean nextPage = itineraryDao.nextPage(pageNumber+1);

		System.out.println("pageNumber=" + pageNumber);
		model.addAttribute("member", memberList);
		model.addAttribute("itineraryList", itineraryList);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("pageNumber", pageNumber);
		session.setAttribute("member_idx", "1");
	}
	
	@RequestMapping("itinerary/itineraryOne")
	public void one(ItineraryVO itineraryVO, Model model, PlaceVO placeVO, MemberVO memberVO) {
		ItineraryVO itineraryVO2 = itineraryDao.itineraryReadOne(itineraryVO);
		
		// itineraryVO 에 있는 member_idx를 memberVO의 member_idx로 연결해 member정보 호출
		memberVO.setMember_idx(itineraryVO2.getMember_idx()); 
		MemberVO memberVO2 = memberDao.selectOneIdx(memberVO);
		
		//itineraryVO에서 ,로 연결된 place_idx들을 가져와 split 한 후에 각 place_idx에 해당하는 placeVO호출
		String placesString = itineraryVO2.getItinerary_places();
		String[] placesIdx = placesString.split(",");
		List<PlaceVO> placeList = new ArrayList<PlaceVO>();
		for (String placeIdx : placesIdx){
			placeVO.setPlace_idx(placeIdx);
			placeVO = placeDao.one(placeVO);
			placeList.add(placeVO);
			}
		model.addAttribute("memberOne", memberVO2);
		model.addAttribute("one", itineraryVO2);
		model.addAttribute("placeList", placeList);
//		System.out.println("placeList"+placeList);
//		System.out.println(memberVO2);
	}
	
	@RequestMapping("itinerary/itineraryDelete")
	public void delete(ItineraryVO vo, Model model) { // 게시판 작성글 삭제 기능
		int result = itineraryDao.itineraryDelete(vo);
		model.addAttribute("itineraryResult", result);
	}
	
	@RequestMapping("itinerary/itineraryCreate")
	public void insert(ItineraryVO vo, Model model) { // 게시판 글 작성 기능

		int result = itineraryDao.itineraryCreate(vo); // 성공여부 확인
		String text = "설문지 문제 등록 성공";
		if (result != 1) {
			text = "설문지 문제 등록 실패";
		}
		model.addAttribute("result", text);
	}

	@RequestMapping("itinerary/itineraryUpdate") // 게시판 글 수정1
	public void update(ItineraryVO vo, Model model) {
		ItineraryVO itineraryVO2 = itineraryDao.itineraryReadOne(vo);

		model.addAttribute("itinerary", itineraryVO2);
	}

	@RequestMapping("itinerary/itineraryUpdate2") // 게시판 글 수정2
	public void update2(ItineraryVO vo, Model model) {
		// 수정하고 싶은 것이 있으면 수정처리 요청.
		int result = itineraryDao.itineraryUpdate(vo);
		String text = "설문지 수정 성공";
		if (result != 1) {
			text = "설문지 수정 실패";
		}
		model.addAttribute("result", text);
		model.addAttribute("readone", vo);
	}
}
