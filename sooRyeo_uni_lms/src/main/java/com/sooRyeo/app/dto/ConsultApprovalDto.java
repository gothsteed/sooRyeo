package com.sooRyeo.app.dto;

public class ConsultApprovalDto {
    private Integer schedule_seq;
    private boolean isApproved;

    public Integer getSchedule_seq() {
        return schedule_seq;
    }

    public void setSchedule_seq(Integer schedule_seq) {
        this.schedule_seq = schedule_seq;
    }

    public boolean getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }
}
