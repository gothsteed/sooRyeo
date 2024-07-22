package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.LoginLog;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginLogRepository extends MongoRepository<LoginLog, String> {

	List<LoginLog> findAllByMemberType(String student);

	List<LoginLog> findAllByUserid(int i);

	List<LoginLog> findALLByTimestamp();

	List<LoginLog> findByTimestampBetween(Instant startOfDay, Instant endOfDay);



}
