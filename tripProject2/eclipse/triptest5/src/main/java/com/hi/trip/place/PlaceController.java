package com.hi.trip.place;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller 

public class PlaceController {
	

		@Autowired
		PlaceDAO dao; 
		
	

		@RequestMapping("place/pShowSearch")
		public void info(PlaceVO vo , Model model ) {
			List<PlaceVO> list = dao.pShowSearch(vo);
			System.out.println(list);
			model.addAttribute("list", list);
		}
		@RequestMapping("place/pDetail")
		public void detail(PlaceVO vo , Model model ) {
			PlaceVO vo2 = dao.one(vo);
			model.addAttribute("one", vo2);
		}
}
