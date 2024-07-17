package com.sooRyeo.app.controller.binder;

import java.beans.PropertyEditorSupport;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class LocalDateTimeBinder extends PropertyEditorSupport {
    private final DateTimeFormatter formatter;

    public LocalDateTimeBinder(DateTimeFormatter formatter) {
        this.formatter = formatter;
    }

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        setValue(LocalDateTime.parse(text, formatter));
    }

    @Override
    public String getAsText() {
        LocalDateTime value = (LocalDateTime) getValue();
        return value == null ? "" : value.format(formatter);
    }

}
