package com.sooRyeo.app.domain;

import lombok.Getter;
import org.json.JSONObject;

import java.time.Duration;
import java.time.LocalDateTime;

@Getter
public class Exam implements ScheduleInterface{
    private Integer fk_schedule_seq;
    private Integer fk_course_seq;
    private String file_name;
    private String original_file_name;
    private String answer_mongo_id;
    private Integer question_count;
    private Integer total_score;
    private Integer end_date_seconds;
    

    private Schedule schedule;
    


    public LocalDateTime getStartDate() {
        return  schedule.getStartLocalDateTime();
    }

    public long getDurationInMinute() {
        Duration duration = schedule.getDuration();
        return  duration.toMinutes();
    }

    @Override
    public LocalDateTime getStartLocalDateTime() {
        return null;
    }

    @Override
    public LocalDateTime getEndLocalDateTime() {
        return null;
    }

    @Override
    public Duration getDuration() {
        return null;
    }

    @Override
    public boolean isBefore(LocalDateTime localDateTime) {
        return schedule.isBefore(localDateTime);
    }

    @Override
    public boolean isAfter(LocalDateTime localDateTime) {
        return schedule.isAfter(localDateTime);
    }

    @Override
    public JSONObject toJson() {
        JSONObject jsonobj  = schedule.toJson();
        jsonobj.put("course_seq", fk_course_seq);
        return jsonobj;
    }

    public boolean isBetween(LocalDateTime time) {
        return schedule.isBetween(time);
    }

    public long getSecondsTillEnd() {
        LocalDateTime endDate = schedule.getEndLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        return Duration.between(now, endDate).toSeconds();
    }
}
