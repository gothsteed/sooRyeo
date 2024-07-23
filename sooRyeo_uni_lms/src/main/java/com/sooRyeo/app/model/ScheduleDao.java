package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Consult;
import com.sooRyeo.app.dto.ConsultApprovalDto;

public interface ScheduleDao {
	
	// 스케줄테이블 select
	List<Map<String, String>> showAssignment(int userid);
	
	// 내 일정 테이블 select
	List<Map<String, String>> showTodo(int userid);
	
	// 상담 테이블 select
	List<Map<String, String>> showConsult(int userid);
	
	// 내 개인일정 update - 스케줄테이블 update
	int update_tbl_schedule(String schedule_seq, String title, String start_date, String end_date);

	// 내 개인일정 update - todo테이블 update
	int update_tbl_todo(String schedule_seq, String content);

	// 내 개인일정 insert - 스케줄테이블 insert
	int insert_tbl_schedule(String title, String start_date, String end_date, String content, int userid);

	// 내 개인일정 삭제 - todo 테이블 delete
	int delete_tbl_todo(String schedule_seq);
	
	// 내 개인일정 삭제 - 스케줄 테이블 delete
	int delete_tbl_schedule(String schedule_seq);

	List<Consult> getUnconfirmedConsultList(int currentPage, int sizePerPage, int professor_id);

	int getUnconfirmedConsultCount( int professor_id);

	



    Consult getConsult(int schedule_seq);

	int updateConsultApproveStatus(ConsultApprovalDto consultApprovalDto);

	int deleteUnapprovedConsult(ConsultApprovalDto consultApprovalDto);

    List<Consult> getConfirmedConsultList(int professorId, int currentPage, int sizePerPage);

	int getConfirmedConsultCount(int professorId);

    void updateToComplete(Integer scheduleSeq);

    List<Consult> getStudentConfirmedConsultList(int studentId, int currentPage, int sizePerPage);

	int getStudentConfirmedConsultCount(int studentId);
}
