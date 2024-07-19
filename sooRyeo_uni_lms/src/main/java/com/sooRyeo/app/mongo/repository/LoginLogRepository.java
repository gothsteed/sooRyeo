package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.LoginLog;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginLogRepository extends MongoRepository<LoginLog, String> {

	List<LoginLog> findAllByMemberType(String student);

	List<LoginLog> findAllByUserid(int i);



}
