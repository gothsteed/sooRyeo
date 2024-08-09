package com.sooRyeo.app.config;

import net.bramp.ffmpeg.FFprobe;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
public class FFprobeConfig {

    @Bean
    public FFprobe fFprobeConfig() throws IOException {

        String os = System.getProperty("os.name").toLowerCase();
        String ffprobePath;

/*        String ffprobePath = "C:\\ffmpeg-7.0.1-essentials_build\\bin\\ffprobe.exe";
        String ffprobePath = "/usr/bin/ffprobe";*/

        if (os.contains("win")) {
            // Path for Windows
            ffprobePath = "C:\\ffmpeg-7.0.1-essentials_build\\bin\\ffprobe.exe";
        } else {
            // Path for Linux
            ffprobePath = "/usr/bin/ffprobe";
        }

        return new FFprobe(ffprobePath);
    }
}
