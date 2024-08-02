package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.MemberType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MessageAggregationRepositoryImpl implements MessageAggregationRepository {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public Map<String, Map<String, Object>> getUnreadCountPerRoom(MemberType memberType, Integer studentId) {
        String userKey = memberType.toString() + studentId;

        MatchOperation matchOperation = Aggregation.match(Criteria.where("readStatus").ne(userKey));
        GroupOperation groupOperation = Aggregation.group("roomId").count().as("unreadCount");

        LookupOperation lookupOperation = Aggregation.lookup("chatRooms", "roomIdObj", "_id", "roomInfo");

        ProjectionOperation projectionOperation = Aggregation.project()
                .and("_id").as("roomId")
                .and("unreadCount").as("unreadCount")
                .and("roomInfo.name").as("roomName");

        Aggregation aggregation = Aggregation.newAggregation(
                matchOperation,
                groupOperation,
                lookupOperation,
                projectionOperation
        );

        AggregationResults<Map> results = mongoTemplate.aggregate(aggregation, "messages", Map.class);

        // Convert results to Map<String, Map<String, Object>>
        Map<String, Map<String, Object>> unreadCounts = new HashMap<>();
        for (Map result : results.getMappedResults()) {
            String roomId = (String) result.get("roomId");
            Integer unreadCount = ((Number) result.get("unreadCount")).intValue();
            String roomName =  (String) ((List<String>)result.get("roomName")).get(0);
            Map<String, Object> roomData = new HashMap<>();
            roomData.put("roomName", roomName);
            roomData.put("unreadCount", unreadCount);
            unreadCounts.put(roomId, roomData);
        }

        return unreadCounts;
    }
}
