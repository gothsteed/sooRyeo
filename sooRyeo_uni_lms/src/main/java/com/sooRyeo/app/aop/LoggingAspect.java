package com.sooRyeo.app.aop;

import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.mongo.entity.LoginLog;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.repository.LoginLogRepository;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@Aspect
public class LoggingAspect {

    @Autowired
    private LoginLogRepository loginLogRepository;

    private String determineUserType(String methodName) {
        if (methodName.contains("student")) {
            return MemberType.STUDENT.toString();
        } else if (methodName.contains("professor")) {
            return MemberType.PROFESSOR.toString();
        } else {
            return MemberType.ADMIN.toString();
        }
    }

    @Around("@within(logging) || @annotation(logging)")
    public Object logging(ProceedingJoinPoint joinPoint, Logging logging) throws Throwable {
        if (logging == null) {
            logging = joinPoint.getTarget().getClass().getAnnotation(Logging.class);
        }

        if (logging != null && logging.type() == LogType.LOGIN) {
            return handleLoginLogging(joinPoint);
        }

        //todo : 다른 로깅 처리
        return handleLoginLogging(joinPoint);
    }


    private Object handleLoginLogging(ProceedingJoinPoint joinPoint) throws Throwable {
        JSONObject loginResult =  (JSONObject) joinPoint.proceed();

        if(!loginResult.getBoolean("isSuccess"))  {
            return loginResult;
        }

        LoginLog log = new LoginLog();


        Object[] args = joinPoint.getArgs();
        if (args.length > 1 && args[1] instanceof LoginDTO) {
            LoginDTO loginDTO = (LoginDTO) args[1];
            log.setUserid(loginDTO.getId());
            log.setMemberType(determineUserType(joinPoint.getSignature().getName()));
        }


        log.setTimestamp(LocalDateTime.now());

        loginLogRepository.save(log);

        return loginResult;

    }
}
