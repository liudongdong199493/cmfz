package com.baizhi.util;

import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;

import java.io.File;

public class FileUtil {
    public static String getDuration(File file) {
        String duration = "";
        try {
            MP3File f = (MP3File) AudioFileIO.read(file);
            MP3AudioHeader audioHeader = (MP3AudioHeader) f.getAudioHeader();
            int length = audioHeader.getTrackLength();
            duration = length / 60 + "分" + length % 60 + "秒";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return duration;
    }
}
