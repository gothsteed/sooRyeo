package com.sooRyeo.app.config;

import net.bramp.ffmpeg.FFprobe;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
public class FFprobeConfig {

    @Bean
    public FFprobe fFprobeConfig() throws IOException {
        return  new FFprobe("C:\\ffmpeg-7.0.1-essentials_build\\bin\\ffprobe.exe");
    }
}
