package com.sooRyeo.app.mongo.service;

import com.sooRyeo.app.domain.Consult;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.StudentDTO;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.model.StudentDao;
import com.sooRyeo.app.mongo.entity.ChatRoom;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.entity.Message;
import com.sooRyeo.app.mongo.repository.ChatRoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ChatService_imple implements ChatService {

    @Autowired
    private ChatRoomRepository chatRoomRepository;

    @Autowired
    private ScheduleDao scheduleDao;

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private JsonBuilder jsonBuilder;

    @Override
    @Transactional
    public ResponseEntity<String> createChatRoom(HttpServletRequest request, HttpServletResponse response, Integer scheduleSeq) {

        Consult consult = scheduleDao.getConsult(scheduleSeq);

        if(!consult.isAvailableTime(LocalDateTime.now())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("시간대가 맞지 않습니다.");
        }
        Student student = studentDao.getStudentById(consult.getFk_student_id());
        HttpSession session = request.getSession();
        Professor professor = ((Professor) session.getAttribute("loginuser"));


        chatRoomRepository.save(new ChatRoom( consult.getStudent().getStudent_id(),
                student.getName(),
                professor.getProf_id() ,
                professor.getName(),
                consult.getSchedule().getTitle(),
                consult.getContent()));
        //scheduleDao.updateToComplete(scheduleSeq);

        return ResponseEntity.status(HttpStatus.OK).body("채팅방 생성 성공");
    }

    @Override
    public ResponseEntity<String> showChatRoom(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        Professor professor = ((Professor) session.getAttribute("loginuser"));
        List<ChatRoom> roomList = chatRoomRepository.findAllByProfessorId(professor.getProf_id());

        return ResponseEntity.ok().body(jsonBuilder.toJson(roomList));
    }

    @Override
    public ResponseEntity<String> deleteChatRoom(HttpServletRequest request, HttpServletResponse response) {

        String chatRoomId = request.getParameter("roomId");
        chatRoomRepository.deleteById(chatRoomId);

        return ResponseEntity.ok("상담이 종료되었습니다.");
    }

    @Override
    public ModelAndView getChatPage(HttpServletRequest request, ModelAndView mav) {
        HttpSession session = request.getSession();
        if(session.getAttribute("loginuser") instanceof Student) {
            Student student = (Student) session.getAttribute("loginuser");
            mav.addObject("senderId", student.getStudent_id());
            mav.addObject("senderType", "STUDENT");

        }else if (session.getAttribute("loginuser") instanceof Professor) {
            Professor professor = (Professor) session.getAttribute("loginuser");
            mav.addObject("senderId", professor.getProf_id());
            mav.addObject("senderType", "PROFESSOR");
        }

        mav.addObject("roomId", request.getParameter("roomId"));
        mav.setViewName("chatting");

        return mav;
    }
}
