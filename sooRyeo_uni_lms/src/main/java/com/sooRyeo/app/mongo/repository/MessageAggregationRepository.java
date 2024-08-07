package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.MemberType;

import java.util.List;
import java.util.Map;

public interface MessageAggregationRepository {
    Map<String, Map<String, Object>> getUnreadCountPerRoom(MemberType memberType, Integer memberId);
}
