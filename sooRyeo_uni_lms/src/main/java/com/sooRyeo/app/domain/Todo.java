package com.sooRyeo.app.domain;

import org.json.JSONObject;

import java.time.Duration;
import java.time.LocalDateTime;

public class Todo implements ScheduleInterface{

    private Integer schedule_seq;
    private String content;
    private Integer fk_student_id;

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
        jsonobj.put("content", content);

        return jsonobj;
    }
}
