package com.spring.view.myPage;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.biz.myPage.BookingsService;
import com.spring.biz.myPage.BookingsVO;
import com.spring.biz.myPage.CalService;
import com.spring.biz.myPage.CalVO;


@Controller
@SessionAttributes("cal")
public class CalController {
	@Autowired
	private CalService calService;
	@Autowired
	private BookingsService bookingsService;
	
	//예약하기 
	@RequestMapping(value = "reserve.do")
	public String reserve () {
		return "myPage/calendar/reserve";
	}
	
	//일정관리 들어가기 전 설정
	/*@RequestMapping(value = "BeforeSearchCal.do")
	public String config (CalVO vo, Model model) {
		model.addAttribute("HotelNameList",calService.getHotelNameList(vo));
		System.out.println(model);
		return "myPage/calendar/BeforeSearchCal";
	}*/
	
	//선진 : 일정 검색
	@RequestMapping(value = "calendar.do")
	public String searchCal (Model model, BookingsVO vo) {
		model.addAttribute("bookingsList", bookingsService.getBookingsListBefore(vo));
		return "myPage/calendar/calendar";
	}
	
	//일정관리(달력) 페이지 이동
//	@RequestMapping(value = "cal.do")
//	public String cal (CalVO vo, Model model) {
//		model.addAttribute("HotelNameList",calService.getHotelNameList(vo));
//		return "myPage/calendar/config";
//	}
	
	//일정등록 
    @RequestMapping(value = "schedule.do", method = RequestMethod.GET)
	public String schedule () {
		return "myPage/calendar/schedule";
	}
	
	//예약하기 화면에서 등록 눌렀을때
	@RequestMapping(value = "calRegister.do")
	public String calRegister(CalVO vo, Model model) {
		calService.setCal(vo);
		List<CalVO> list = calService.getCal(vo);
		for(int i=0;i<list.size();i++)
			System.out.println(list.get(i));
		model.addAttribute("resList",calService.getCal(vo));
		
		model.addAttribute("myhotelName", vo.getHotelName());
		//model은 세션과 비슷한 것. 
		//db에서 가져온 데이터를 모델에 넣고 모델에 있는 값을 el표현식 반복문 forEach써서 view에서 받는다
		System.out.println(model);//콘솔에서 확인하는 작업(db에서 가져온 데이터가 잘 있는지)
		
		return "myPage/calendar/searchCal";
	}
	
	//달력화면에서 날짜 눌렀을때
/*	@RequestMapping(value = "calclick.do")
	public String calclick(CalVO vo, Model model) {
		List<CalVO> list = calService.getCal(vo);
		for(int i=0;i<list.size();i++)
			System.out.println(list.get(i));
		model.addAttribute("resList",calService.getCal(vo));
		//로직 생성
		
		return "myPage/calendar/cal";
	}*/
	
	@RequestMapping(value = "calclick.do")
	public String calclick(BookingsVO vo, Model model) {
		List<BookingsVO> calResvCont = bookingsService.getCalRevs(vo);
		model.addAttribute("resvCont",calResvCont);
		
		return "myPage/calendar/resvPop";
	}
	
	/*// 게시판 목록
	@RequestMapping(value = "getBoardList.do", method = RequestMethod.GET)
	public String getBoardList(Criteria cri, Model model, HttpServletRequest request) {		
		model.addAttribute("boardList", boardService.getBoardList(cri));
		int total = boardService.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "board/getBoardList"; 
		}*/

}