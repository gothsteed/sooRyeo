package com.sooRyeo.app.domain;

import lombok.Getter;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
public class Exam {
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

    public boolean isBefore(LocalDateTime localDateTime) {
        return schedule.isBefore(localDateTime);
    }

    public boolean isAfter(LocalDateTime localDateTime) {
        return schedule.isAfter(localDateTime);
    }

    public boolean isBetween(LocalDateTime time) {
        return schedule.isBetweenSchedule(time);
    }

    public long getSecondsTillEnd() {
        LocalDateTime endDate = schedule.getEndLocalDateTime();
        LocalDateTime now = LocalDateTime.now();
        return Duration.between(now, endDate).toSeconds();
    }
}
