package com.sooRyeo.app.domain;


import lombok.Getter;
import org.json.JSONObject;

import java.io.Serializable;
import java.time.Duration;
import java.time.LocalDateTime;

@Getter
public class Assignment implements ScheduleInterface{
	
    private Integer schedule_seq_assignment;
    private Integer fk_course_seq;
    private String content;
    private String attatched_file;
    private String orgfilename;

    private Schedule schedule;


    @Override
    public boolean isBetween(LocalDateTime time) {
        return schedule.isBetween(time);
    }

    @Override
    public LocalDateTime getStartLocalDateTime() {
        return schedule.getStartLocalDateTime();
    }

    @Override
    public LocalDateTime getEndLocalDateTime() {
        return schedule.getEndLocalDateTime();
    }

    @Override
    public Duration getDuration() {
        return schedule.getDuration();
    }

    @Override
    public boolean isBefore(LocalDateTime time) {
        return schedule.isBefore(time);
    }

    @Override
    public boolean isAfter(LocalDateTime time) {
        return schedule.isAfter(time);
    }

    @Override
    public JSONObject toJson() {
        JSONObject jsonobj = schedule.toJson();
        jsonobj.put("course_seq", fk_course_seq);

        return jsonobj;
    }
}
