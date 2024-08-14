package com.sooRyeo.app.domain;

import org.json.JSONObject;

import java.time.Duration;
import java.time.LocalDateTime;

public interface ScheduleInterface {

    boolean isBetween(LocalDateTime time);
    LocalDateTime getStartLocalDateTime();
    LocalDateTime getEndLocalDateTime();
    Duration getDuration();
    boolean isBefore(LocalDateTime time);
    boolean isAfter(LocalDateTime time);
    JSONObject toJson();
}
